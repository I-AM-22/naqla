import { Admin } from '../../../models/admins';
import { Employee } from '../../../models/employees';
import { User } from '../../../models/users';
import {
  SignUpDto,
  LoginDto,
  PasswordChangeDto,
  ForgotPasswordDto,
  ResetPasswordDto,
} from '../../dtos';
import { AuthUserResponse } from '../auth-user.interface';
import { jwtPayload } from '../jwt-payload.interface';

export interface IAuthService {
  signup(dto: SignUpDto): Promise<{ message: string }>;

  login(dto: LoginDto): Promise<AuthUserResponse>;

  confirm(otp: string): Promise<AuthUserResponse>;
  updateMyPassword(
    dto: PasswordChangeDto,
    phone: string,
  ): Promise<AuthUserResponse>;

  forgotPassword(dto: ForgotPasswordDto): Promise<{ message: string }>;
  resetPassword(
    dto: ResetPasswordDto,
    dynamicOrigin: string,
  ): Promise<AuthUserResponse>;

  sendAuthResponse(user: User): Promise<AuthUserResponse>;

  validate(payload: jwtPayload): Promise<User | Admin | Employee>;
}
