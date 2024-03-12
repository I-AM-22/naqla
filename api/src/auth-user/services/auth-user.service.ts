import {
  Injectable,
  UnauthorizedException,
  Inject,
  UnprocessableEntityException,
} from '@nestjs/common';
import { User } from '../../models/users';
import { JwtTokenService } from '../../shared/jwt';
import {
  SignUpUserDto,
  LoginUserDto,
  ConfirmUserDto,
  UpdateUserPhoneDto,
} from '../dtos';
import { AuthUserResponse, jwtPayload } from '../interfaces';
import { Admin } from '../../models/admins';

import {
  confirmMessage,
  incorrect_credentials,
  incorrect_phone_number,
  item_already_exist,
} from '../../common/constants';
import { Employee } from '../../models/employees';
import { MailService } from '../../shared/mail/mail.service';
import { ADMIN_TYPES } from '../../models/admins/interfaces/type';
import { EMPLOYEE_TYPES } from '../../models/employees/interfaces/type';
import { USER_TYPES } from '../../models/users/interfaces/type';
import { ROLE_TYPES } from '../../models/roles/interfaces/type';
import { IAuthUserService } from '../interfaces/services/auth.service.interface';
import { RedisStoreService } from '../../shared/redis-store';
import { OtpsService } from '../../models/otps/otps.service';
import { OTP_TYPE } from '../../models/otps/otp.enum';
import { Entities, ROLE } from '../../common/enums';
import { IRolesService } from '../../models/roles/interfaces/services/roles.service.interface';
import { IUsersService } from '../../models/users/interfaces/services/users.service.interface';
import { IAdminsService } from '../../models/admins/interfaces/services/admins.service.interface';
import { IEmployeeService } from '../../models/employees/interfaces/employee-services.interface';
import { IOtp } from '../../models/otps/interfaces/otp.interface';
import { SendConfirm } from '../../common/types';

@Injectable()
export class AuthUserService implements IAuthUserService {
  constructor(
    private readonly jwtTokenService: JwtTokenService,
    @Inject(USER_TYPES.service)
    private readonly usersService: IUsersService,
    @Inject(ADMIN_TYPES.service)
    private readonly adminsService: IAdminsService,
    @Inject(EMPLOYEE_TYPES.service)
    private readonly employeesService: IEmployeeService,
    @Inject(ROLE_TYPES.service)
    private readonly rolesService: IRolesService,
    private readonly mailService: MailService,
    private redisStoreService: RedisStoreService,
    private otpsService: OtpsService,
  ) {}
  async signup(dto: SignUpUserDto, ip: string): Promise<SendConfirm> {
    const user = await this.usersService.findOneByPhone(dto.phone);
    if (!user) {
      const otp = await this.otpsService.findOneForUser(
        dto.phone,
        ip,
        OTP_TYPE.CHANGE_NUMBER,
      );

      if (otp) {
        throw new UnprocessableEntityException(item_already_exist('mobile'));
      }
      const role = await this.rolesService.findByName(ROLE.USER);

      const newUser = await this.usersService.create(dto, role);

      await this.otpsService.createForUser({
        phone: newUser.phone,
        userId: newUser.id,
        ip,
        type: OTP_TYPE.SIGNUP,
      });
    } else if (user.active) {
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
    if (!user || !user.active)
      throw new UnauthorizedException(incorrect_phone_number);
    const otp = await this.otpsService.findOneForUser(
      dto.phone,
      ip,
      OTP_TYPE.LOGIN,
    );
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

  async confirm(
    dto: ConfirmUserDto,
    ip: string,
    phoneConfirm: boolean,
  ): Promise<AuthUserResponse> {
    let user: User;
    const otp = await this.otpsService.findOneOtpForUser(
      dto.phone,
      dto.otp,
      ip,
      phoneConfirm,
    );
    if (!otp) {
      throw new UnauthorizedException(incorrect_credentials);
    }
    const nonConfirmedUser = await this.usersService.findOne(otp.userId);
    if (!nonConfirmedUser) {
      throw new UnauthorizedException(incorrect_credentials);
    }

    if (phoneConfirm) {
      user = await this.usersService.updatePhone(nonConfirmedUser, {
        phone: otp.phone,
      });
    } else {
      if (otp.type === OTP_TYPE.SIGNUP)
        user = await this.usersService.confirm(nonConfirmedUser);
      else user = nonConfirmedUser;
    }
    await this.otpsService.updateForUser(otp);
    return this.sendAuthResponse(user);
  }

  async updatePhone(
    dto: UpdateUserPhoneDto,
    ip: string,
    user: User,
  ): Promise<SendConfirm> {
    const otp = await this.otpsService.findOneForUser(
      dto.phone,
      ip,
      OTP_TYPE.CHANGE_NUMBER,
    );

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

  async validate(payload: jwtPayload): Promise<User | Admin | Employee> {
    let user: any;

    if (payload.entity === Entities.Admin) {
      user = await this.adminsService.validate(payload.sub, payload.iat);
    } else if (payload.entity === Entities.User) {
      user = await this.usersService.validate(payload.sub);
    } else {
      user = await this.employeesService.validate(payload.sub, payload.iat);
    }

    return user;
  }
}
