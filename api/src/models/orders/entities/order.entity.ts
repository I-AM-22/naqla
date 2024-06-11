import { GlobalEntity } from '@common/base';
import { Advantage } from '@models/advantages/entities/advantage.entity';
import { User } from '@models/users/entities/user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude, Type } from 'class-transformer';
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
import { OrderPhoto } from './order-photo.entity';
// import { GROUPS } from '@common/enums';
import { ORDER_STATUS } from '@common/enums';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';
import { Location } from '../interfaces/location.interface';
import { Payment } from './payment.entity';
import { MiniUser } from '@models/users/interfaces/mini-user.interface';

@Entity('orders')
export class Order extends GlobalEntity {
  @ApiProperty()
  @Column()
  desiredDate: Date;

  @ApiProperty({ enum: ORDER_STATUS })
  @Column({ enum: ORDER_STATUS, default: ORDER_STATUS.WAITING })
  status: ORDER_STATUS;

  @ApiProperty({ default: 0 })
  @Column({ default: 0 })
  porters: number;

  @ApiProperty()
  @Type(() => Location)
  @Column({ type: 'jsonb', nullable: true })
  locationStart: Location; // Using custom type for locationStart

  @ApiProperty()
  @Column({ type: 'jsonb', nullable: true })
  @Type(() => Location)
  locationEnd: Location; // Using custom type for locationEnd

  @ApiProperty({ type: () => MiniUser })
  @ManyToOne(() => User, (user) => user.orders)
  @JoinColumn({ referencedColumnName: 'id', name: 'userId' })
  user: User;

  @Exclude()
  @Column('uuid')
  userId: string;

  @ApiProperty({ isArray: true, type: () => OrderPhoto })
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
