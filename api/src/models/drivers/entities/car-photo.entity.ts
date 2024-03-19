import { Column, Entity, JoinColumn, OneToOne } from 'typeorm';
import { BasePhoto } from '../../../common/base';
import { Car } from './car.entity';
import { Exclude } from 'class-transformer';

@Entity({ name: 'cars_photos' })
export class CarPhoto extends BasePhoto {
  @OneToOne(() => Car, (car) => car.photo)
  @JoinColumn({ name: 'carId' })
  car: Car;

  @Exclude()
  @Column()
  carId: string;
}
