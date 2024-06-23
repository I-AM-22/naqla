import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { ApiProperty } from '@nestjs/swagger';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';
import { Exclude } from 'class-transformer';

@Entity('messages')
export class Message extends GlobalEntity {
  @ApiProperty()
  @Column()
  content: string;

  @ApiProperty()
  @Column()
  isUser: boolean;

  @ManyToOne(() => SubOrder, (subOrder) => subOrder.messages)
  @JoinColumn({ name: 'subOrderId', referencedColumnName: 'id' })
  subOrder: SubOrder;

  @Exclude()
  @Column('uuid')
  subOrderId: string;
}
