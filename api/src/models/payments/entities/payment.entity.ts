import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { Order } from '@models/orders/entities/order.entity';
import { Exclude } from 'class-transformer';
import { GlobalEntity } from '../../../common/base';
import { ApiProperty } from '@nestjs/swagger';

@Entity('payments')
export class Payment extends GlobalEntity {
  @ApiProperty()
  @Column({ default: 0 })
  cost: number;

  @ApiProperty()
  @Column({ default: 0 })
  additionalCost: number;

  // @ApiProperty()
  // @Column({ default: PaymentStatus.pending })
  // status: PaymentStatus;

  // @ApiProperty()
  // @Column({ default: '' })
  // methodType: HyperPayMethods;

  // @ApiProperty()
  // @Column({ default: '' })
  // reference: string;

  // @ApiProperty()
  // @Column({ default: '' })
  // transactionId: string;

  @ApiProperty({ default: '2022-2-2' })
  @Column({ nullable: true, type: 'timestamptz' })
  deliveredDate: Date;

  @OneToOne(() => Order, (order) => order.payment)
  @JoinColumn({ name: 'orderId', referencedColumnName: 'id' })
  order: Order;

  @Exclude()
  @Column('uuid')
  orderId: string;
}
