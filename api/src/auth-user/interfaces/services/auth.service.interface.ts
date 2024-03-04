import { Admin } from '../../../models/admins';
import { Employee } from '../../../models/employees';
import { User } from '../../../models/users';
import { SignUpDto, LoginDto, ConfirmDto, UpdatePhoneDto } from '../../dtos';
import { AuthUserResponse } from '../auth-user.interface';
import { jwtPayload } from '../jwt-payload.interface';
import { SendConfirm } from '../type';

export interface IAuthService {
  signup(dto: SignUpDto): Promise<SendConfirm>;

  login(dto: LoginDto): Promise<SendConfirm>;

  updatePhone(dto: UpdatePhoneDto, user: User): Promise<SendConfirm>;

  confirm(dto: ConfirmDto, phoneConfirm: boolean): Promise<AuthUserResponse>;

  validate(payload: jwtPayload): Promise<User | Admin | Employee>;
}
