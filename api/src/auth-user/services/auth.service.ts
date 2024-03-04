import {
  Injectable,
  UnauthorizedException,
  Inject,
  UnprocessableEntityException,
} from '@nestjs/common';
import { ROLE } from '../../common/enums';
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
  ) {}
  async signup(dto: SignUpDto): Promise<SendConfirm> {
    const role = await this.roleRepository.findByName(ROLE.USER);
    if (!role) throw new UnprocessableEntityException('role not found');
    await this.userRepository.create(dto, role);
    return { message: confirmMessage };
  }

  async login(dto: LoginDto): Promise<SendConfirm> {
    const user = await this.userRepository.findOneByPhone(dto.phone);
    if (!user) throw new UnauthorizedException(incorrect_phone_number);
    await this.userRepository.createOtp(user);
    return { message: confirmMessage };
  }

  async confirm(
    dto: ConfirmDto,
    phoneConfirm: boolean,
  ): Promise<AuthUserResponse> {
    const nonConfirmedUser = await this.userRepository.findOneForConfirm(
      dto,
      phoneConfirm,
    );
    if (!nonConfirmedUser)
      throw new UnauthorizedException(incorrect_credentials);
    const user = await this.userRepository.confirm(
      nonConfirmedUser,
      phoneConfirm,
    );
    return this.sendAuthResponse(user);
  }

  async updatePhone(dto: UpdatePhoneDto, user: User): Promise<SendConfirm> {
    this.userRepository.updatePhone(user, dto);
    await this.redisStoreService.storeToken('');
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
    console.log(user);
    return user;
  }
}
