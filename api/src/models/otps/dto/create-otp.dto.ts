import { IsEnum, IsNotEmpty, IsString, IsUUID } from 'class-validator';
import { OTP_TYPE } from '../otp.enum';

export class CreateOtpDto {
  @IsUUID()
  readonly userId: string;

  @IsString()
  @IsNotEmpty()
  readonly phone: string;

  @IsEnum(OTP_TYPE)
  @IsNotEmpty()
  readonly type: OTP_TYPE;
}
