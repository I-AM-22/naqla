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
import { ORDER_STATUSES } from '../../../common/enums';
import { Payment } from './payment.entity';
import { SubOrder } from '../../sub-orders/entities/sub-order.entity';

@Entity('orders')
export class Order extends GlobalEntity {
  @Expose({ groups: [GROUPS.ALL_CARS, GROUPS.CAR] })
  @ApiProperty()
  @Column()
  desiredDate: Date;

  @ApiProperty({ enum: ORDER_STATUSES })
  @Column({ enum: ORDER_STATUSES, default: ORDER_STATUSES.WAITING })
  status: ORDER_STATUSES;

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
  @ManyToMany(() => Advantage, (advantage) => advantage.orders)
  @JoinTable({ name: 'orders_advantages' })
  advantages: Advantage[];

  @ApiProperty()
  @OneToOne(() => Payment, (payment) => payment.order, {
    cascade: true,
  })
  @JoinColumn({ referencedColumnName: 'id', name: 'paymentId' })
  payment: Payment;

  @Exclude()
  @Column('uuid', { nullable: true })
  paymentId: string;

  @Exclude()
  @OneToMany(() => SubOrder, (subOrder) => subOrder.order, { cascade: true })
  subOrders: SubOrder[];
}
