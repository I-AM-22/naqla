// advantage.entity.ts
import { Column, Entity, ManyToMany } from 'typeorm';
import { Car } from '@models/cars/entities/car.entity';
import { GlobalEntity } from '@common/base';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { Order } from '@models/orders/entities/order.entity';

@Entity('advantages')
export class Advantage extends GlobalEntity {
  @ApiProperty()
  @Column({ unique: true })
  name: string;

  @ApiProperty()
  @Column({ type: 'decimal', precision: 10, scale: 2 })
  cost: number;

  @Exclude()
  @Column('boolean', { default: true })
  active: boolean;

  @ManyToMany(() => Car, (car) => car.advantages)
  cars: Car[];

  @ManyToMany(() => Order, (order) => order.advantages)
  orders: Order[];
}
