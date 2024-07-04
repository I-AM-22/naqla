import { Column, Entity } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { OTP_PERSON, OTP_TYPE } from '@common/enums/otp.enum';

@Entity('otps')
export class Otp extends GlobalEntity {
  @Column('uuid')
  userId: string;

  @Column()
  ip: string;

  @Column({ enum: OTP_PERSON })
  perType: OTP_PERSON;

  @Column()
  phone: string;

  @Column()
  otp: string;

  @Column({ type: 'timestamptz' })
  expiresIn: Date;

  @Column({ enum: OTP_TYPE })
  type: OTP_TYPE;

  @Column('boolean', { default: true })
  valid: boolean;
}
