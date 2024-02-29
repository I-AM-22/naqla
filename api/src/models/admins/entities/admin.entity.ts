import {
  BeforeInsert,
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
} from 'typeorm';
import { Exclude, Expose, Transform } from 'class-transformer';
import { Role } from '../../roles';
import { AdminPhoto } from './admin-photo.entity';
import { BasePerson, BasePhoto } from '../../../common/entities';
import { GROUPS } from '../../../common/enums';
import { ApiProperty } from '@nestjs/swagger';

@Entity({ name: 'admins' })
export class Admin extends BasePerson {
  @Expose({ groups: [GROUPS.ADMIN] })
  @Transform(({ value }) => value.name)
  @ManyToOne(() => Role, (role) => role.admins)
  @JoinColumn({ name: 'roleId' })
  role: Role;

  @Exclude()
  @Column()
  roleId: string;

  @Exclude()
  @OneToMany(() => AdminPhoto, (adminPhoto) => adminPhoto.admin, {
    cascade: true,
  })
  photos: AdminPhoto[];

  @Expose()
  @ApiProperty({ type: BasePhoto })
  photo() {
    return this.photos[this.photos.length - 1];
  }
}
