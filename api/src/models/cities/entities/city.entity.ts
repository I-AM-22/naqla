import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity } from 'typeorm';
import { GlobalEntity } from '@common/base';

@Entity({ name: 'cities' })
export class City extends GlobalEntity {
  @ApiProperty()
  @Column({ unique: true })
  name: string;
}
