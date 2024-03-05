import {
  Injectable,
  UnauthorizedException,
  Inject,
  UnprocessableEntityException,
} from '@nestjs/common';
import { User } from '../../models/users';
import { JwtTokenService } from '../../shared/jwt';
import { SignUpDto, LoginDto, ConfirmDto, UpdatePhoneDto } from '../dtos';
import { AuthUserResponse, SendConfirm, jwtPayload } from '../interfaces';
import { Admin } from '../../models/admins';

import {
  password_changed_recently,
  confirmMessage,
  incorrect_phone_number,
  incorrect_credentials,
  item_already_exist,
} from '../../common/constants';
import { Employee } from '../../models/employees';
import { MailService } from '../../shared/mail/mail.service';
import { IAdminRepository } from '../../models/admins/interfaces/repositories/admin.repository.interface';
import { ADMIN_TYPES } from '../../models/admins/interfaces/type';
import { IEmployeeRepository } from '../../models/employees/interfaces/repositories/employee.repository.interface';
import { EMPLOYEE_TYPES } from '../../models/employees/interfaces/type';
import { USER_TYPES } from '../../models/users/interfaces/type';
import { IUserRepository } from '../../models/users/interfaces/repositories/user.repository.interface';
import { ROLE_TYPES } from '../../models/roles/interfaces/type';
import { IRoleRepository } from '../../models/roles/interfaces/repositories/role.repository.interface';
import { IAuthService } from '../interfaces/services/auth.service.interface';
import { RedisStoreService } from '../../shared/redis-store';
import { OtpsService } from '../../models/otps/otps.service';
import { OTP_TYPE } from '../../models/otps/otp.enum';
import { ROLE } from '../../common/enums';

@Injectable()
export class AuthService implements IAuthService {
  constructor(
    private readonly jwtTokenService: JwtTokenService,
    @Inject(USER_TYPES.repository.user)
    private readonly userRepository: IUserRepository,
    @Inject(ADMIN_TYPES.repository.admin)
    private readonly adminRepository: IAdminRepository,
    @Inject(EMPLOYEE_TYPES.repository.employee)
    private readonly employeeRepository: IEmployeeRepository,
    @Inject(ROLE_TYPES.repository)
    private readonly roleRepository: IRoleRepository,
    private readonly mailService: MailService,
    private redisStoreService: RedisStoreService,
    private otpsService: OtpsService,
  ) {}
  async signup(dto: SignUpDto): Promise<SendConfirm> {
    const user = await this.userRepository.findOneByPhone(dto.phone);
    if (!user) {
      const otp = await this.otpsService.findOne(
        dto.phone,
        OTP_TYPE.CHANGE_NUMBER,
      );

      if (otp) {
        throw new UnprocessableEntityException(item_already_exist('mobile'));
      }
      const role = await this.roleRepository.findByName(ROLE.USER);

      if (!role) throw new UnprocessableEntityException('role not found');

      const newUser = await this.userRepository.create(dto, role);
      await this.otpsService.create({
        phone: newUser.phone,
        userId: newUser.id,
        type: OTP_TYPE.SIGNUP,
      });
    } else if (user.active) {
      throw new UnprocessableEntityException(item_already_exist('mobile'));
    } else if (!user.active) {
      await this.otpsService.create(
        {
          phone: user.phone,
          userId: user.id,
          type: OTP_TYPE.SIGNUP,
        },
        {
          phone: user.phone,
          type: OTP_TYPE.SIGNUP,
        },
      );
    }

    return { message: confirmMessage };
  }

  async login(dto: LoginDto): Promise<SendConfirm> {
    const user = await this.userRepository.findOneByPhone(dto.phone);
    if (!user || !user.active)
      throw new UnauthorizedException(incorrect_phone_number);
    await this.otpsService.create({
      userId: user.id,
      phone: user.phone,
      type: OTP_TYPE.LOGIN,
    });
    return { message: confirmMessage };
  }

  async confirm(
    dto: ConfirmDto,
    phoneConfirm: boolean,
  ): Promise<AuthUserResponse> {
    let user: User;
    const otp = await this.otpsService.findOneOtp(
      dto.phone,
      dto.otp,
      phoneConfirm,
    );
    if (!otp) {
      throw new UnauthorizedException(incorrect_credentials);
    }
    const nonConfirmedUser = await this.userRepository.findOneById(otp.userId);
    if (!nonConfirmedUser)
      throw new UnauthorizedException(incorrect_credentials);

    if (phoneConfirm) {
      user = await this.userRepository.updatePhone(nonConfirmedUser, {
        phone: otp.phone,
      });
    } else {
      if (otp.type === OTP_TYPE.SIGNUP)
        user = await this.userRepository.confirm(nonConfirmedUser);
      else user = nonConfirmedUser;
    }
    await this.otpsService.update({ phone: otp.phone, type: otp.type });
    return this.sendAuthResponse(user);
  }

  async updatePhone(dto: UpdatePhoneDto, user: User): Promise<SendConfirm> {
    const otp = await this.otpsService.findOne(
      dto.phone,
      OTP_TYPE.CHANGE_NUMBER,
    );

    if (!otp) {
      await this.otpsService.create({
        phone: dto.phone,
        userId: user.id,
        type: OTP_TYPE.CHANGE_NUMBER,
      });
    } else if (otp && otp.userId === user.id) {
      await this.otpsService.create(
        {
          phone: dto.phone,
          userId: user.id,
          type: OTP_TYPE.CHANGE_NUMBER,
        },
        { phone: otp.phone, type: otp.type },
      );
    } else throw new UnprocessableEntityException(item_already_exist('mobile'));

    return { message: confirmMessage };
  }

  async sendAuthResponse(user: User): Promise<AuthUserResponse> {
    const token = await this.jwtTokenService.signToken(user.id, User.name);
    return { token, user };
  }

  async validate(payload: jwtPayload): Promise<User | Admin | Employee> {
    let user: any;

    if (payload.entity === Admin.name) {
      user = await this.adminRepository.validate(payload.sub);
    } else if (payload.entity === User.name) {
      user = await this.userRepository.validate(payload.sub);
    } else {
      user = await this.employeeRepository.validate(payload.sub);
    }

    if (!user) {
      throw new UnauthorizedException('The user is not here');
    }

    if (payload.entity === Admin.name || payload.entity === Employee.name) {
      if (user.isPasswordChanged(payload.iat)) {
        throw new UnauthorizedException(password_changed_recently);
      }
    }
    return user;
  }
}
