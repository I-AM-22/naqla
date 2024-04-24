import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { BasePhoto } from '../../../common/base';
import { Order } from './order.entity';
import { Exclude } from 'class-transformer';

@Entity({ name: 'orders_photos' })
export class OrderPhoto extends BasePhoto {
  @Exclude()
  @ManyToOne(() => Order, (order) => order.photos)
  @JoinColumn({ name: 'orderId' })
  order: Order;

  @Exclude()
  @Column()
  orderId: string;
}
