import { Entity, Column, OneToOne, JoinColumn } from 'typeorm';
import { Order } from '../../orders/entities/order.entity';
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
