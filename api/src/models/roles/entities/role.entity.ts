import { ApiProperty } from '@nestjs/swagger';
import { Expose, Exclude } from 'class-transformer';
import { Entity, Column, ManyToMany, JoinTable, OneToMany } from 'typeorm';
import { GROUPS, ROLE } from '../../../common/enums';
import { Permission } from '../../permissions';
import { User } from '../../users';
import { Admin } from '../../admins';
import { Employee } from '../../employees';
import { GlobalEntity } from '../../../common/entities';

@Entity({ name: 'roles' })
export class Role extends GlobalEntity {
  @Expose({ groups: [GROUPS.ROLE, GROUPS.ALL_ROLES] })
  @ApiProperty()
  @Column({ unique: true })
  name: ROLE | string;

  @Expose({ groups: [GROUPS.ROLE] })
  @ApiProperty({
    type: Permission,
    isArray: true,
  })
  @ManyToMany(() => Permission, (permission) => permission.roles, {
    onDelete: 'CASCADE',
    cascade: true,
  })
  @JoinTable({
    name: 'roles_permissions',
    joinColumn: { name: 'roleId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'permissionId', referencedColumnName: 'id' },
  })
  permissions: Permission[];

  @Exclude()
  @OneToMany(() => User, (user) => user.role, { cascade: true })
  users: User[];

  @Exclude()
  @OneToMany(() => Admin, (admin) => admin.role, { cascade: true })
  admins: Admin[];

  @Exclude()
  @OneToMany(() => Employee, (employee) => employee.role, { cascade: true })
  employees: Employee[];
}
