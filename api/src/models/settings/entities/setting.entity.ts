import { Entity, Column } from 'typeorm';
import { GlobalEntity } from '@common/base';
import { ApiProperty } from '@nestjs/swagger';

@Entity('settings')
export class Setting extends GlobalEntity {
  @ApiProperty()
  @Column({ unique: true })
  name: string;

  @ApiProperty()
  @Column({ default: 0 })
  cost: number;
}
