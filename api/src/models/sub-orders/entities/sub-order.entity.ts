import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { Car } from '@models/cars/entities/car.entity';
import { ApiProperty } from '@nestjs/swagger';
import { SUB_ORDER_STATUS } from '@common/enums';
import { OrderPhoto } from '@models/orders/entities/order-photo.entity';
import { Order } from '@models/orders/entities/order.entity';
import { Exclude } from 'class-transformer';
import { Message } from '@models/messages/entities/message.entity';

@Entity('sub_orders')
export class SubOrder extends GlobalEntity {
  @ApiProperty()
  @Column({ default: 0 })
  rating: number;

  @ApiProperty()
  @Column({ default: null })
  note: string;

  @ApiProperty()
  @Column({ default: null })
  repeatDriver: boolean;

  @ApiProperty()
  @Column({ default: 0 })
  weight: number;

  @ApiProperty()
  @Column({ default: 0 })
  cost: number;

  @ApiProperty()
  @Column({ default: 0 })
  realCost: number;

  @ApiProperty()
  @Column({ default: SUB_ORDER_STATUS.WAITING })
  status: SUB_ORDER_STATUS;

  @ApiProperty()
  @Column({ nullable: true, type: 'timestamptz' })
  acceptedAt: Date;

  @ApiProperty()
  @Column({ nullable: true, type: 'timestamptz' })
  arrivedAt: Date;

  @ApiProperty()
  @Column({ nullable: true, type: 'timestamptz' })
  deliveredAt: Date;

  @ApiProperty()
  @Column({ nullable: true, type: 'timestamptz' })
  driverAssignedAt: Date;

  @ApiProperty()
  @Column({ nullable: true, type: 'timestamptz' })
  pickedUpAt: Date;

  @ApiProperty({ type: () => Order })
  @ManyToOne(() => Order, (order) => order.subOrders)
  @JoinColumn({ name: 'orderId', referencedColumnName: 'id' })
  order: Order;

  @Exclude()
  @Column('uuid')
  orderId: string;

  @ApiProperty({ type: () => Car })
  @ManyToOne(() => Car, (car) => car.subOrders, { nullable: true })
  @JoinColumn({ name: 'carId', referencedColumnName: 'id' })
  car: Car;

  @Exclude()
  @Column('uuid', { nullable: true })
  carId: string;

  @ApiProperty()
  @OneToMany(() => OrderPhoto, (photo) => photo.subOrder, {
    eager: true,
  })
  photos: OrderPhoto[];

  @OneToMany(() => Message, (message) => message.subOrder, { cascade: true })
  messages: Message[];
}
