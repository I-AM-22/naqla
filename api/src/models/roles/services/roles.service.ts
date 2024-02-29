import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { CreateRoleDto, UpdateRoleDto } from '../dtos';
import { Role } from '../entities/role.entity';
import { item_not_found } from '../../../common/constants';
import { Entities } from '../../../common/enums';
import { IPermissionsService } from '../../permissions/interfaces/services/permissions.service.interface';
import { PERMISSION_TYPES } from '../../permissions/interfaces/type';
import { IRoleRepository } from '../interfaces/repositories/role.repository.interface';
import { ROLE_TYPES } from '../interfaces/type';
import { IRolesService } from '../interfaces/services/roles.service.interface';

@Injectable()
export class RolesService implements IRolesService {
  constructor(
    @Inject(PERMISSION_TYPES.service)
    private permissionsService: IPermissionsService,
    @Inject(ROLE_TYPES.repository)
    private roleRepository: IRoleRepository,
  ) {}

  async find(): Promise<Role[]> {
    return this.roleRepository.find();
  }

  async findOne(
    id: string,
    withDeleted?: boolean,
    relations?: string[],
  ): Promise<Role | undefined> {
    const role = await this.roleRepository.findOne(id, withDeleted, relations);
    if (!role) throw new NotFoundException(item_not_found(Entities.Role));
    return role;
  }

  async findByName(name: string) {
    return this.roleRepository.findByName(name);
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
    if (dto.permissionsIds)
      permissions = await this.permissionsService.find(dto.permissionsIds);

    return this.roleRepository.addPermissions(role, permissions);
  }

  async deletePermissions(id: string, dto: UpdateRoleDto): Promise<Role> {
    const role = await this.findOne(id);

    const permissions = await this.permissionsService.find(dto.permissionsIds);

    return this.roleRepository.deletePermissions(role, permissions);
  }
}
