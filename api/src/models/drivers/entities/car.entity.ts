import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
} from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { Driver } from './driver.entity';
import { OneToOne } from 'typeorm';
import { CarPhoto } from './car-photo.entity';
import { Exclude, Expose } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';
import { Advantage } from '../../advantages/entities/advantage.entity';
import { GROUPS } from '../../../common/enums';

@Entity('cars')
export class Car extends GlobalEntity {
  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  model: string;

  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  brand: string;

  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
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

  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @OneToOne(() => CarPhoto, (photo) => photo.car, {
    cascade: true,
    eager: true,
  })
  photo: CarPhoto;

  @Expose({ groups: [GROUPS.CAR] })
  @ApiProperty()
  @ManyToMany(() => Advantage, (advantage) => advantage.cars, { cascade: true })
  @JoinTable()
  advantages: Advantage[];
}
