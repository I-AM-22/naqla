import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { Driver } from './driver.entity';
import { BasePhoto } from '@common/base';
import { Exclude } from 'class-transformer';

@Entity({ name: 'drivers_photos' })
export class DriverPhoto extends BasePhoto {
  @ManyToOne(() => Driver, (driver) => driver.photos)
  @JoinColumn({ name: 'driverId' })
  driver: Driver;

  @Exclude()
  @Column()
  driverId: string;
}
