import { Permission } from '../../../permissions/entities/permission.entity';
import { CreateRoleDto } from '../../dtos';
import { Role } from '../../entities/role.entity';

export interface IRoleRepository {
  create(dto: CreateRoleDto, permissions: Permission[]): Promise<Role>;

  find(): Promise<Role[]>;

  findOne(id: string, withDeleted?: boolean, relations?: string[]): Promise<Role>;

  findByName(name: string): Promise<Role>;

  update(role: Role, permissions: Permission[]): Promise<Role>;

  addPermissions(role: Role, permissions: Permission[]): Promise<Role>;

  deletePermissions(role: Role, permissions: Permission[]): Promise<Role>;
}
// async findPermissionsByRoleName(roleName: string) {
//     const { permissions } = await this.roleRepo
//       .createQueryBuilder('role')
//       .select(['permission.action', 'permission.subject', 'role.name'])
//       .leftJoin('role.permissions', 'permission')
//       .where('role.name = :roleName', { roleName })
//       .getOne();
//     return permissions;
//   }
