import { Column, Entity, JoinColumn, OneToOne } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { Driver } from './driver.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude, Expose } from 'class-transformer';

@Entity('drivers_wallets')
export class DriverWallet extends GlobalEntity {
  @OneToOne(() => Driver, (driver) => driver.wallet)
  @JoinColumn({ name: 'driverId', referencedColumnName: 'id' })
  driver: Driver;

  @Exclude()
  @Column('uuid')
  driverId: string;

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
