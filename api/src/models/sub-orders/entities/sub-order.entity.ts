import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { Car } from '@models/drivers/entities/car.entity';
import { ApiProperty } from '@nestjs/swagger';
import { SUB_ORDER_STATUS } from '@common/enums';
import { OrderPhoto } from '@models/orders/entities/order-photo.entity';
import { Order } from '@models/orders/entities/order.entity';
import { Exclude } from 'class-transformer';

@Entity('sub_orders')
export class SubOrder extends GlobalEntity {
  @ApiProperty()
  @Column({ default: 0 })
  rating: number;

  @ApiProperty()
  @Column({ default: 0 })
  weight: number;

  @ApiProperty()
  @Column({ default: 0 })
  cost: number;

  @ApiProperty()
  @Column({ default: SUB_ORDER_STATUS.WAITING })
  status: SUB_ORDER_STATUS;

  @ApiProperty()
  @Column({ nullable: true })
  acceptedAt: string;

  @ApiProperty()
  @Column({ nullable: true })
  arrivedAt: string;

  @ApiProperty()
  @Column({ nullable: true })
  deliveredAt: string;

  @ApiProperty()
  @Column({ nullable: true })
  driverAssignedAt: string;

  @ApiProperty()
  @Column({ nullable: true })
  pickedUpAt: string;

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
}
