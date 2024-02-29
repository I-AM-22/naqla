import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { GlobalEntity } from '../../../common/entities';

@Entity({ name: 'cities' })
export class City extends GlobalEntity {
  @ApiProperty()
  @Column({ unique: true })
  name: string;
}
