import { Column, Entity, JoinColumn, OneToOne } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { User } from './user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude, Expose } from 'class-transformer';

@Entity('users_wallets')
export class UserWallet extends GlobalEntity {
  @OneToOne(() => User, (user) => user.wallet)
  @JoinColumn({ name: 'userId', referencedColumnName: 'id' })
  user: User;

  @Exclude()
  @Column('uuid')
  userId: string;

  @ApiProperty({ default: 0 })
  @Column({ type: 'int', default: 0 })
  total: number;

  @ApiProperty({ default: 0 })
  @Column({ type: 'int', default: 0 })
  pending: number;

  @ApiProperty({ default: 0 })
  @Expose()
  available() {
    return this.total - this.pending;
  }
}
