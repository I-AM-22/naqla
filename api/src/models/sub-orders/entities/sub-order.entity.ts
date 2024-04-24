import { Column, Entity, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { GlobalEntity } from '../../../common/base';
import { Order } from '../../orders';
import { Car } from '../../drivers/entities/car.entity';
import { ApiProperty } from '@nestjs/swagger';
import { SubOrderPhoto } from './sub-order-photo.entity';

@Entity('sub_orders')
export class SubOrder extends GlobalEntity {
  @ApiProperty()
  @Column({ default: 0 })
  rating: number;

  @ApiProperty()
  @Column({ default: 0 })
  cost: number;

  @ApiProperty()
  @Column({ nullable: true })
  arrivalDate: string;

  @ApiProperty()
  @Column({ nullable: true })
  deliveryDate: string;

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
  @OneToMany(() => SubOrderPhoto, (photo) => photo.subOrder, {
    cascade: true,
    eager: true,
  })
  photos: SubOrderPhoto[];
}
