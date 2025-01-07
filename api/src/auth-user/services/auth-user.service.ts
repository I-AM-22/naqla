import { Injectable, UnauthorizedException, UnprocessableEntityException } from '@nestjs/common';
import { User } from '@models/users/entities/user.entity';
import { JwtTokenService } from '@shared/jwt';
import { SignUpUserDto, LoginUserDto, ConfirmUserDto, UpdateUserPhoneDto } from '../dtos';
import { AuthUserResponse, jwtPayload } from '../interfaces';

import {
  confirmMessage,
  incorrect_credentials_OTP,
  incorrect_phone_number,
  item_already_exist,
} from '@common/constants';
import { OtpsService } from '@models/otps/services/otps.service';
import { OTP_TYPE } from '@common/enums/otp.enum';
import { Entities } from '@common/enums';
import { IOtp } from '@models/otps/interfaces/otp.interface';
import { SendConfirm } from '@common/types';
import { UsersService } from '@models/users/services/users.service';

@Injectable()
export class AuthUserService {
  constructor(
    private readonly jwtTokenService: JwtTokenService,
    private readonly usersService: UsersService,
    private otpsService: OtpsService,
  ) {}
  async signup(dto: SignUpUserDto, ip: string): Promise<SendConfirm> {
    const user = await this.usersService.findOneByPhone(dto.phone);

    if (!user) {
      const otp = await this.otpsService.findOneForUser(dto.phone, ip, OTP_TYPE.CHANGE_NUMBER);

      if (otp) {
        throw new UnprocessableEntityException(item_already_exist('mobile'));
      }

      const newUser = await this.usersService.create(dto);

      await this.otpsService.createForUser({
        phone: newUser.phone,
        userId: newUser.id,
        ip,
        type: OTP_TYPE.SIGNUP,
      });
    } else if (user.disactiveAt !== null || user.active) {
      throw new UnprocessableEntityException(item_already_exist('mobile'));
    } else if (!user.active) {
      const otp: IOtp = {
        phone: dto.phone,
        ip,
        type: OTP_TYPE.SIGNUP,
        userId: user.id,
      };
      await this.otpsService.createForUser(
        {
          phone: user.phone,
          userId: user.id,
          ip,
          type: OTP_TYPE.SIGNUP,
        },
        otp,
      );
    }

    return { message: confirmMessage };
  }

  async login(dto: LoginUserDto, ip: string): Promise<SendConfirm> {
    const user = await this.usersService.findOneByPhone(dto.phone);
    console.log(user);
    if (!user || !user.active || user.disactiveAt !== null) throw new UnauthorizedException(incorrect_phone_number);
    const otp = await this.otpsService.findOneForUser(dto.phone, ip, OTP_TYPE.LOGIN);
    await this.otpsService.createForUser(
      {
        userId: user.id,
        phone: user.phone,
        ip,
        type: OTP_TYPE.LOGIN,
      },
      otp,
    );
    return { message: confirmMessage };
  }

  async confirm(dto: ConfirmUserDto, ip: string, phoneConfirm: boolean): Promise<AuthUserResponse> {
    let user: User;
    const otp = await this.otpsService.findOneOtpForUser(dto.phone, dto.otp, ip, phoneConfirm);
    if (!otp) {
      throw new UnauthorizedException(incorrect_credentials_OTP);
    }
    const nonConfirmedUser = await this.usersService.findOne(otp.userId);
    if (!nonConfirmedUser || nonConfirmedUser.disactiveAt !== null) {
      throw new UnauthorizedException(incorrect_credentials_OTP);
    }

    if (phoneConfirm) {
      user = await this.usersService.updatePhone(nonConfirmedUser, {
        phone: otp.phone,
      });
    } else {
      if (otp.type === OTP_TYPE.SIGNUP) user = await this.usersService.confirm(nonConfirmedUser);
      else user = nonConfirmedUser;
    }
    await this.otpsService.updateForUser(otp);
    return this.sendAuthResponse(user);
  }

  async updatePhone(dto: UpdateUserPhoneDto, ip: string, user: User): Promise<SendConfirm> {
    const otp = await this.otpsService.findOneForUser(dto.phone, ip, OTP_TYPE.CHANGE_NUMBER);

    if (!otp) {
      await this.otpsService.createForUser({
        phone: dto.phone,
        userId: user.id,
        ip,
        type: OTP_TYPE.CHANGE_NUMBER,
      });
    } else if (otp && otp.userId === user.id) {
      await this.otpsService.createForUser(
        {
          phone: dto.phone,
          userId: user.id,
          ip,
          type: OTP_TYPE.CHANGE_NUMBER,
        },
        otp,
      );
    } else throw new UnprocessableEntityException(item_already_exist('mobile'));

    return { message: confirmMessage };
  }

  async sendAuthResponse(user: User): Promise<AuthUserResponse> {
    const token = await this.jwtTokenService.signToken(user.id, Entities.User);
    return { token, user };
  }

  async validate(payload: jwtPayload): Promise<User> {
    if (payload.entity !== Entities.User) return;
    const user = await this.usersService.validate(payload.sub);
    return user;
  }
}
