import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { Admin } from './admin.entity';

import { Exclude } from 'class-transformer';
import { BasePhoto } from '@common/base';

@Entity({ name: 'admins_photos' })
export class AdminPhoto extends BasePhoto {
  @ManyToOne(() => Admin, (admin) => admin.photos)
  @JoinColumn({ name: 'adminId' })
  admin: Admin;

  @Exclude()
  @Column()
  adminId: string;
}
