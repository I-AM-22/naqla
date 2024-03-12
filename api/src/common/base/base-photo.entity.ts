import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { Column, Entity } from 'typeorm';
import { GlobalEntity } from './global-entity.base';

@Entity()
export class BasePhoto extends GlobalEntity {
  @Exclude()
  @Column()
  publicId: string;

  @ApiProperty()
  @Column()
  blurHash: string;

  @ApiProperty()
  @Column()
  profileUrl: string;

  @ApiProperty()
  @Column()
  mobileUrl: string;

  @ApiProperty()
  @Column()
  webUrl: string;
}
