import {
  Column,
  Entity,
  JoinColumn,
  JoinTable,
  ManyToMany,
  ManyToOne,
  OneToMany,
  OneToOne,
} from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { OrderPhoto } from './order-photo.entity';
import { Exclude, Expose, Type } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';
import { Advantage } from '../../advantages/entities/advantage.entity';
import { User } from '../../users/entities/user.entity';
import { GROUPS } from '../../../common/enums';
import { Location } from '../interfaces/location.interface';
import { ORDER_STATUSES } from '../../../common/enums/order-statuses.enum';
import { Payment } from './payment.entity';

@Entity('orders')
export class Order extends GlobalEntity {
  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  desiredDate: Date;

  @ApiProperty({ default: ORDER_STATUSES.WAITING, enum: ORDER_STATUSES })
  @Column()
  status: string;

  @ApiProperty()
  @Type(() => Location)
  @Column({ type: 'jsonb', nullable: true })
  locationStart: Location; // Using custom type for locationStart

  @ApiProperty()
  @Column({ type: 'jsonb', nullable: true })
  @Type(() => Location)
  locationEnd: Location; // Using custom type for locationEnd

  @ManyToOne(() => User, (user) => user.orders)
  @JoinColumn({ referencedColumnName: 'id', name: 'userId' })
  user: User;

  @Exclude()
  @Column('uuid')
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

  @ApiProperty()
  @OneToOne(() => Payment, (payment) => payment.order, {
    cascade: true,
  })
  @JoinColumn({ referencedColumnName: 'id', name: 'paymentId' })
  payment: Payment;

  @Exclude()
  @Column('uuid')
  paymentId: string;
}
