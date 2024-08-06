import { Injectable, UnauthorizedException, Inject, UnprocessableEntityException } from '@nestjs/common';
import { Driver } from '@models/drivers/entities/driver.entity';
import { JwtTokenService } from '@shared/jwt';
import { SignUpDriverDto, LoginDriverDto, ConfirmDriverDto, UpdateDriverPhoneDto } from '../dtos';
import { AuthDriverResponse, jwtPayload } from '../interfaces';

import {
  confirmMessage,
  incorrect_credentials_OTP,
  incorrect_phone_number,
  item_already_exist,
} from '@common/constants';
import { DRIVER_TYPES } from '@models/drivers/interfaces/type';
import { ROLE_TYPES } from '@models/roles/interfaces/type';
import { OtpsService } from '@models/otps/services/otps.service';
import { OTP_TYPE } from '@common/enums/otp.enum';
import { Entities, ROLE } from '@common/enums';
import { IRolesService } from '@models/roles/interfaces/services/roles.service.interface';
import { IDriversService } from '@models/drivers/interfaces/services/drivers.service.interface';
import { IOtp } from '@models/otps/interfaces/otp.interface';
import { IAuthDriverService } from '../interfaces/services/auth.service.interface';
import { SendConfirm } from '@common/types';

@Injectable()
export class AuthDriverService implements IAuthDriverService {
  constructor(
    private readonly jwtTokenService: JwtTokenService,
    @Inject(DRIVER_TYPES.service)
    private readonly driversService: IDriversService,
    @Inject(ROLE_TYPES.service)
    private readonly rolesService: IRolesService,
    private otpsService: OtpsService,
  ) {}
  async signup(dto: SignUpDriverDto, ip: string): Promise<SendConfirm> {
    const driver = await this.driversService.findOneByPhone(dto.phone);
    if (!driver) {
      const otp = await this.otpsService.findOneForDriver(dto.phone, ip, OTP_TYPE.CHANGE_NUMBER);

      if (otp) {
        throw new UnprocessableEntityException(item_already_exist('mobile'));
      }
      const role = await this.rolesService.findByName(ROLE.DRIVER);

      const newDriver = await this.driversService.create(dto, role);

      await this.otpsService.createForDriver({
        phone: newDriver.phone,
        userId: newDriver.id,
        ip,
        type: OTP_TYPE.SIGNUP,
      });
    } else if (driver.disactiveAt !== null || driver.active) {
      throw new UnprocessableEntityException(item_already_exist('mobile'));
    } else if (!driver.active) {
      const otp: IOtp = {
        phone: dto.phone,
        ip,
        type: OTP_TYPE.SIGNUP,
        userId: driver.id,
      };
      await this.otpsService.createForDriver(
        {
          phone: driver.phone,
          userId: driver.id,
          ip,
          type: OTP_TYPE.SIGNUP,
        },
        otp,
      );
    }

    return { message: confirmMessage };
  }

  async login(dto: LoginDriverDto, ip: string): Promise<SendConfirm> {
    const driver = await this.driversService.findOneByPhone(dto.phone);
    if (!driver || !driver.active || driver.disactiveAt !== null)
      throw new UnauthorizedException(incorrect_phone_number);
    const otp = await this.otpsService.findOneForDriver(dto.phone, ip, OTP_TYPE.LOGIN);
    await this.otpsService.createForDriver(
      {
        userId: driver.id,
        phone: driver.phone,
        ip,
        type: OTP_TYPE.LOGIN,
      },
      otp,
    );
    return { message: confirmMessage };
  }

  async confirm(dto: ConfirmDriverDto, ip: string, phoneConfirm: boolean): Promise<AuthDriverResponse> {
    let driver: Driver;
    const otp = await this.otpsService.findOneOtpForDriver(dto.phone, dto.otp, ip, phoneConfirm);
    if (!otp) {
      throw new UnauthorizedException(incorrect_credentials_OTP);
    }
    const nonConfirmedDriver = await this.driversService.findOne(otp.userId);
    if (!nonConfirmedDriver || nonConfirmedDriver.disactiveAt !== null) {
      throw new UnauthorizedException(incorrect_credentials_OTP);
    }

    if (phoneConfirm) {
      driver = await this.driversService.updatePhone(nonConfirmedDriver, {
        phone: otp.phone,
      });
    } else {
      if (otp.type === OTP_TYPE.SIGNUP) driver = await this.driversService.confirm(nonConfirmedDriver);
      else driver = nonConfirmedDriver;
    }
    await this.otpsService.updateForDriver(otp);
    return this.sendAuthResponse(driver);
  }

  async updatePhone(dto: UpdateDriverPhoneDto, ip: string, driver: Driver): Promise<SendConfirm> {
    const otp = await this.otpsService.findOneForDriver(dto.phone, ip, OTP_TYPE.CHANGE_NUMBER);

    if (!otp) {
      await this.otpsService.createForDriver({
        phone: dto.phone,
        userId: driver.id,
        ip,
        type: OTP_TYPE.CHANGE_NUMBER,
      });
    } else if (otp && otp.userId === driver.id) {
      await this.otpsService.createForDriver(
        {
          phone: dto.phone,
          userId: driver.id,
          ip,
          type: OTP_TYPE.CHANGE_NUMBER,
        },
        otp,
      );
    } else throw new UnprocessableEntityException(item_already_exist('mobile'));

    return { message: confirmMessage };
  }

  async sendAuthResponse(driver: Driver): Promise<AuthDriverResponse> {
    const token = await this.jwtTokenService.signToken(driver.id, Entities.Driver);
    return { token, driver };
  }

  async validate(payload: jwtPayload): Promise<Driver> {
    if (payload.entity !== Entities.Driver) return;
    const driver = await this.driversService.validate(payload.sub);
    return driver;
  }
}
