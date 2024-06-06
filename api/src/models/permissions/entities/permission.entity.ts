import { Column, Entity, ManyToMany, Unique } from 'typeorm';
import { IPermission } from '../interfaces';
import { Role } from '@models/roles/entities/role.entity';
import { ApiProperty } from '@nestjs/swagger';
import { GROUPS, Action, Entities } from '@common/enums';
import { Expose } from 'class-transformer';
import { GlobalEntity } from '@common/base';

@Entity({ name: 'permissions' })
@Unique('un_permission', ['action', 'subject'])
export class Permission extends GlobalEntity implements IPermission {
  @Expose({ groups: [GROUPS.PERMISSION, GROUPS.ALL_PERMISSIONS, GROUPS.ROLE] })
  @ApiProperty()
  @Column({ enum: Action })
  action: Action;

  @Expose({ groups: [GROUPS.PERMISSION, GROUPS.ALL_PERMISSIONS, GROUPS.ROLE] })
  @ApiProperty()
  @Column({ enum: Entities })
  subject: Entities;

  @Expose({ groups: [GROUPS.PERMISSION] })
  @ManyToMany(() => Role, (role) => role.permissions, {
    onDelete: 'CASCADE',
  })
  roles: Role[];
}
