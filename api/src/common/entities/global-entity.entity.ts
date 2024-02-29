import { ApiProperty } from '@nestjs/swagger';
import { Expose, Exclude } from 'class-transformer';
import {
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  DeleteDateColumn,
  BaseEntity,
} from 'typeorm';
import { GROUPS } from '../enums';

export abstract class GlobalEntity extends BaseEntity {
  @ApiProperty()
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Expose({
    groups: [
      GROUPS.USER,
      GROUPS.ADMIN,
      GROUPS.EMPLOYEE,
      GROUPS.PERMISSION,
      GROUPS.ROLE,
      GROUPS.ALL_PRODUCTS,
      GROUPS.PRODUCT,
    ],
  })
  @ApiProperty()
  @CreateDateColumn()
  createdAt: Date;

  @Expose({
    groups: [
      GROUPS.USER,
      GROUPS.ADMIN,
      GROUPS.EMPLOYEE,
      GROUPS.PERMISSION,
      GROUPS.ROLE,
      GROUPS.ALL_PRODUCTS,
      GROUPS.PRODUCT,
    ],
  })
  @ApiProperty()
  @UpdateDateColumn()
  updatedAt: Date;

  @Exclude()
  @DeleteDateColumn()
  deletedAt: Date;
}
