import { ApiProperty } from '@nestjs/swagger';
import { Expose, Exclude } from 'class-transformer';
import { Entity, Column, ManyToMany, JoinTable, OneToMany } from 'typeorm';
import { GROUPS, ROLE } from '@common/enums';
import { Permission } from '@models/permissions/entities/permission.entity';
import { User } from '@models/users/entities/user.entity';
import { Admin } from '@models/admins/entities/admin.entity';
import { Employee } from '@models/employees/entities/employee.entity';
import { GlobalEntity } from '@common/base';
import { Driver } from '@models/drivers/entities/driver.entity';

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

  @Exclude()
  @OneToMany(() => Driver, (driver) => driver.role, { cascade: true })
  drivers: Driver[];
}
