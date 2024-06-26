import { Column, Entity, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany } from 'typeorm';
import { BasePhoto, GlobalEntity } from '@common/base';
import { Driver } from '../../drivers/entities/driver.entity';
import { CarPhoto } from './car-photo.entity';
import { Exclude, Expose } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';
import { Advantage } from '@models/advantages/entities/advantage.entity';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';

@Entity('cars')
export class Car extends GlobalEntity {
  // @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  model: string;

  // @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  brand: string;

  // @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  color: string;

  @Exclude()
  @Column('boolean', { default: true })
  active: boolean;

  @ManyToOne(() => Driver, (driver) => driver.cars)
  @JoinColumn()
  driver: Driver;

  @Exclude()
  @Column()
  driverId: string;

  @Exclude()
  @OneToMany(() => CarPhoto, (photo) => photo.car, {
    cascade: true,
    eager: true,
  })
  photos: CarPhoto[];

  // @Expose({ groups: [GROUPS.CAR] })
  @ApiProperty({ isArray: true, type: () => Advantage })
  @ManyToMany(() => Advantage, (advantage) => advantage.cars)
  @JoinTable({ name: 'cars_advantages' })
  advantages: Advantage[];

  @Exclude()
  @OneToMany(() => SubOrder, (subOrder) => subOrder.car)
  subOrders: SubOrder[];

  @Expose({})
  @ApiProperty({ type: BasePhoto })
  photo() {
    if (this.photos) return this.photos[this.photos.length - 1];
    return undefined;
  }
}
