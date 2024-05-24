import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { Order, OrderPhoto } from '../../orders';
import { Car } from '../../drivers/entities/car.entity';
import { ApiProperty } from '@nestjs/swagger';
import { SUB_ORDER_STATUS } from '../../../common/enums';

@Entity('sub_orders')
export class SubOrder extends GlobalEntity {
  @ApiProperty()
  @Column({ default: 0 })
  rating: number;

  @ApiProperty()
  @Column({ default: 0 })
  cost: number;

  @ApiProperty()
  @Column({ default: SUB_ORDER_STATUS.READY })
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

  @ApiProperty()
  @ManyToOne(() => Order, (order) => order.subOrders)
  @JoinColumn({ name: 'orderId', referencedColumnName: 'id' })
  order: Order;

  @Column('uuid')
  orderId: string;

  @ApiProperty()
  @ManyToOne(() => Car, (car) => car.subOrders)
  @JoinColumn({ name: 'carId', referencedColumnName: 'id' })
  car: Car;

  @Column('uuid')
  carId: string;

  @ApiProperty()
  @OneToMany(() => OrderPhoto, (photo) => photo.subOrder, {
    eager: true,
  })
  photos: OrderPhoto[];
}
