import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { BasePhoto } from '../../../common/base';
import { Exclude } from 'class-transformer';
import { SubOrder } from './sub-order.entity';

@Entity({ name: 'sub_orders_photos' })
export class SubOrderPhoto extends BasePhoto {
  @Exclude()
  @ManyToOne(() => SubOrder, (subOrder) => subOrder.photos)
  @JoinColumn({ name: 'subOrderId' })
  subOrder: SubOrder;

  @Exclude()
  @Column()
  subOrderId: string;
}
