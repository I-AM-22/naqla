import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { BasePhoto } from '@common/base';
import { Car } from './car.entity';
import { Exclude } from 'class-transformer';

@Entity({ name: 'cars_photos' })
export class CarPhoto extends BasePhoto {
  @ManyToOne(() => Car, (car) => car.photos)
  @JoinColumn({ name: 'carId' })
  car: Car;

  @Exclude()
  @Column()
  carId: string;
}
