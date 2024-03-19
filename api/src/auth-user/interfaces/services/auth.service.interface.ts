import { User } from '../../../models/users';
import {
  SignUpUserDto,
  LoginUserDto,
  ConfirmUserDto,
  UpdateUserPhoneDto,
} from '../../dtos';
import { AuthUserResponse } from '../auth-user.interface';
import { jwtPayload } from '../../../common/interfaces/jwt-payload.interface';
import { SendConfirm } from '../../../common/types';

export interface IAuthUserService {
  signup(dto: SignUpUserDto, ip: string): Promise<SendConfirm>;

  login(dto: LoginUserDto, ip: string): Promise<SendConfirm>;

  updatePhone(
    dto: UpdateUserPhoneDto,
    ip: string,
    user: User,
  ): Promise<SendConfirm>;

  confirm(
    dto: ConfirmUserDto,
    ip: string,
    phoneConfirm: boolean,
  ): Promise<AuthUserResponse>;

  validate(payload: jwtPayload): Promise<User>;
}
