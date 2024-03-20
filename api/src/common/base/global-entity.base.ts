import { ApiProperty } from '@nestjs/swagger';
import { Exclude, Expose } from 'class-transformer';
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
      GROUPS.ADVANTAGE,
      GROUPS.CAR,
      GROUPS.DRIVER,
      GROUPS.ADVANTAGE,
    ],
    toPlainOnly: true,
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
      GROUPS.ADVANTAGE,
      GROUPS.CAR,
      GROUPS.DRIVER,
      GROUPS.ADVANTAGE,
    ],
    toPlainOnly: true,
  })
  @ApiProperty()
  @UpdateDateColumn()
  updatedAt: Date;

  @Exclude()
  @DeleteDateColumn()
  deletedAt: Date;
}
