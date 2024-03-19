import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { Driver } from './driver.entity';
import { OneToOne } from 'typeorm';
import { CarPhoto } from './car-photo.entity';
import { Exclude } from 'class-transformer';

@Entity('cars')
export class Car extends GlobalEntity {
  @Column()
  model: string;

  @Column()
  brand: string;

  @Column()
  color: string;

  @ManyToOne(() => Driver, (driver) => driver.cars)
  @JoinColumn()
  driver: Driver;

  @Exclude()
  @Column()
  driverId: string;

  @OneToOne(() => CarPhoto, (photo) => photo.car, {
    cascade: true,
    eager: true,
  })
  photo: CarPhoto;
}
