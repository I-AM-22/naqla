// advantage.entity.ts
import { Column, Entity, ManyToMany } from 'typeorm';
import { Car } from '../../drivers/entities/car.entity';
import { GlobalEntity } from '../../../common/base';
import { ApiProperty } from '@nestjs/swagger';
import { Exclude, Expose } from 'class-transformer';
import { GROUPS } from '../../../common/enums';
import { Order } from '../../orders/entities/order.entity';

@Entity('advantages')
export class Advantage extends GlobalEntity {
  @Expose({ groups: [GROUPS.ADVANTAGE, GROUPS.ALL_ADVANTAGES, GROUPS.CAR] })
  @ApiProperty()
  @Column({ unique: true })
  name: string;

  @Expose({ groups: [GROUPS.ADVANTAGE, GROUPS.ALL_ADVANTAGES, GROUPS.CAR] })
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
