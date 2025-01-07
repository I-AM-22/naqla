import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { CreateRoleDto, UpdateRoleDto } from '../dtos';
import { Role } from '../entities/role.entity';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';
import { IRoleRepository } from '../interfaces/repositories/role.repository.interface';
import { ROLE_TYPES } from '../interfaces/type';
import { PermissionsService } from '@models/permissions/services/permissions.service';

@Injectable()
export class RolesService {
  constructor(
    private permissionsService: PermissionsService,
    @Inject(ROLE_TYPES.repository)
    private roleRepository: IRoleRepository,
  ) {}

  async find(): Promise<Role[]> {
    return this.roleRepository.find();
  }

  async findOne(id: string, withDeleted?: boolean, relations?: string[]): Promise<Role | undefined> {
    const role = await this.roleRepository.findOne(id, withDeleted, relations);
    if (!role) throw new NotFoundException(item_not_found(Entities.Role));
    return role;
  }

  async findByName(name: string) {
    const role = await this.roleRepository.findByName(name);
    if (!role) throw new NotFoundException(item_not_found(Entities.Role));
    return role;
  }
  async create(dto: CreateRoleDto): Promise<Role> {
    const permissions = await this.permissionsService.find(dto.permissionsIds);

    const role = await this.roleRepository.create(dto, permissions);
    return role;
  }

  async update(id: string, dto: UpdateRoleDto): Promise<Role> {
    const role = await this.findOne(id);

    if (!role) throw new NotFoundException(item_not_found(Entities.Role));

    const permissions = await this.permissionsService.find(dto.permissionsIds);

    return this.roleRepository.update(role, permissions);
  }

  async addPermissions(id: string, dto: UpdateRoleDto): Promise<Role> {
    const role = await this.findOne(id);

    if (!role) throw new NotFoundException(item_not_found(Entities.Role));

    let permissions;
    if (dto.permissionsIds) permissions = await this.permissionsService.find(dto.permissionsIds);

    return this.roleRepository.addPermissions(role, permissions);
  }

  async deletePermissions(id: string, dto: UpdateRoleDto): Promise<Role> {
    const role = await this.findOne(id);

    const permissions = await this.permissionsService.find(dto.permissionsIds);

    return this.roleRepository.deletePermissions(role, permissions);
  }
}
