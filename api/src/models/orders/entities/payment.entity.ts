import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { Order } from './order.entity';
import { Exclude } from 'class-transformer';
import { GlobalEntity } from '../../../common/base';

@Entity('payments')
export class Payment extends GlobalEntity {
  @Column({ nullable: true, default: 0 })
  total: number;

  @Column({ nullable: true, default: 0 })
  additionalCost: number;

  @Column({ nullable: true })
  deliveredDate: Date;

  @OneToOne(() => Order, (order) => order.payment)
  @JoinColumn({ name: 'orderId', referencedColumnName: 'id' })
  order: Order;

  @Exclude()
  @Column('uuid')
  orderId: string;
}
