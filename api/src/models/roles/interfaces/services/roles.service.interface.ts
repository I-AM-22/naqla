import { CreateRoleDto, UpdateRoleDto } from '../../dtos';
import { Role } from '../../entities/role.entity';

export interface IRolesService {
  find(): Promise<Role[]>;
  findOne(
    id: string,
    withDeleted?: boolean,
    relations?: string[],
  ): Promise<Role>;

  findByName(name: string);
  create(dto: CreateRoleDto): Promise<Role>;
  update(id: string, dto: UpdateRoleDto): Promise<Role>;
  addPermissions(id: string, dto: UpdateRoleDto): Promise<Role>;
  deletePermissions(id: string, dto: UpdateRoleDto): Promise<Role>;
}
