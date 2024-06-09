import { OTP_PERSON, OTP_TYPE } from '@common/enums/otp.enum';

export interface IOtp {
  id?: string;

  ip: string;

  userId: string;

  perType?: OTP_PERSON;

  phone: string;

  otp?: string;

  expiresIn?: Date;

  type: OTP_TYPE;

  valid?: boolean;
}
