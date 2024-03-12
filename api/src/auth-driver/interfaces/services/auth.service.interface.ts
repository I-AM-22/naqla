import { Driver } from '../../../models/drivers';
import {
  SignUpDriverDto,
  LoginDriverDto,
  ConfirmDriverDto,
  UpdateDriverPhoneDto,
} from '../../dtos';
import { AuthDriverResponse } from '../auth-driver.interface';
import { jwtPayload } from '../../../common/interfaces/jwt-payload.interface';
import { SendConfirm } from '../../../common/types';

export interface IAuthDriverService {
  signup(dto: SignUpDriverDto, ip: string): Promise<SendConfirm>;

  login(dto: LoginDriverDto, ip: string): Promise<SendConfirm>;

  updatePhone(
    dto: UpdateDriverPhoneDto,
    ip: string,
    driver: Driver,
  ): Promise<SendConfirm>;

  confirm(
    dto: ConfirmDriverDto,
    ip: string,
    phoneConfirm: boolean,
  ): Promise<AuthDriverResponse>;

  validate(payload: jwtPayload): Promise<Driver>;
}
