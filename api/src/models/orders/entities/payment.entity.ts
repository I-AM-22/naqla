import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { Order } from './order.entity';
import { Exclude, Expose } from 'class-transformer';
import { GlobalEntity } from '@common/base';

@Entity('payments')
export class Payment extends GlobalEntity {
  @Column({ default: 0 })
  cost: number;

  @Column({ default: 0 })
  additionalCost: number;

  @Column({ nullable: true })
  deliveredDate: Date;

  @OneToOne(() => Order, (order) => order.payment)
  @JoinColumn({ name: 'orderId', referencedColumnName: 'id' })
  order: Order;

  @Exclude()
  @Column('uuid')
  orderId: string;

  @Expose()
  total() {
    return this.cost + this.additionalCost;
  }
}
