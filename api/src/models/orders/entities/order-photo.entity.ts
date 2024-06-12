import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { BasePhoto } from '@common/base';
import { Order } from './order.entity';
import { Exclude } from 'class-transformer';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';
import { ApiProperty } from '@nestjs/swagger';

@Entity({ name: 'orders_photos' })
export class OrderPhoto extends BasePhoto {
  @Exclude()
  @ManyToOne(() => Order, (order) => order.photos)
  @JoinColumn({ name: 'orderId' })
  order: Order;

  @Exclude()
  @Column()
  orderId: string;

  @ApiProperty({ default: 0 })
  @Column({ default: 0 })
  weight: number;

  @ApiProperty({ default: 0 })
  @Column({ default: 0 })
  length: number;

  @ApiProperty({ default: 0 })
  @Column({ default: 0 })
  width: number;

  @Exclude()
  @ManyToOne(() => SubOrder, (subOrder) => subOrder.photos, { nullable: true })
  @JoinColumn({ name: 'subOrderId' })
  subOrder: SubOrder;

  @Exclude()
  @Column({ nullable: true })
  subOrderId: string;
}
