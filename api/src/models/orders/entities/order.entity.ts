import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
} from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { OrderPhoto } from './order-photo.entity';
import { Exclude, Expose, Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';
import { Advantage } from '../../advantages/entities/advantage.entity';
import { User } from '../../users/entities/user.entity';
import { GROUPS } from '../../../common/enums';

export class Location {
  @ApiProperty()
  longitude: number;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  region: string;

  @ApiProperty()
  street: string;
}
// type Location = {
//   longitude: number;
//   latitude: number;
//   region: string;
//   street: string;
// };
@Entity('orders')
export class Order extends GlobalEntity {
  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  receiving_date: Date;

  @ApiProperty({ default: 'waiting' })
  @Column()
  status: string;

  @ApiProperty()
  @Column()
  cost: number;

  @ApiProperty()
  @Column({ type: 'jsonb', nullable: true })
  @Type(() => Location)
  locationStart: Location; // Using custom type for locationStart

  @ApiProperty()
  @Column({ type: 'jsonb', nullable: true })
  @Type(() => Location)
  locationEnd: Location; // Using custom type for locationEnd

  @ManyToOne(() => User, (user) => user.orders)
  @JoinColumn()
  user: User;

  @Exclude()
  @Column()
  userId: string;

  @ApiProperty()
  @OneToMany(() => OrderPhoto, (photo) => photo.order, {
    cascade: true,
    eager: true,
  })
  photos: OrderPhoto[];

  @ApiProperty()
  @ManyToMany(() => Advantage, (advantage) => advantage.orders, {
    cascade: true,
  })
  @JoinTable({ name: 'orders_advantages' })
  advantages: Advantage[];
}
