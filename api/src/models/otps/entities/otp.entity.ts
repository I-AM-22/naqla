import { Column, Entity } from 'typeorm';
import { GlobalEntity } from '../../../common/entities';
import { OTP_TYPE } from '../otp.enum';

@Entity('otps')
export class Otp extends GlobalEntity {
  @Column('uuid')
  userId: string;

  @Column()
  phone: string;

  @Column()
  otp: string;

  @Column({ default: new Date(Date.now() + 24 * 60 * 60 * 1000) })
  expiresIn: Date;

  @Column({ enum: OTP_TYPE })
  type: OTP_TYPE;

  @Column('boolean', { default: true })
  valid: boolean;
}
