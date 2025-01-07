import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';
import { Permission } from '../entities/permission.entity';
import { IPermissionRepository } from '../interfaces/repositories/permission.repository.interface';
import { PERMISSION_TYPES } from '../interfaces/type';

@Injectable()
export class PermissionsService {
  constructor(
    @Inject(PERMISSION_TYPES.repository)
    public permissionRepository: IPermissionRepository,
  ) {}

  async find(permissionsIds?: string[]): Promise<Permission[]> {
    const permissions = await this.permissionRepository.find(permissionsIds);

    if (permissionsIds && permissionsIds.length !== permissions.length)
      throw new NotFoundException('some of permissions not found');

    return permissions;
  }

  async findOne(id: string, withDeleted?: boolean): Promise<Permission> {
    const permission = await this.permissionRepository.findOne(id, withDeleted);
    if (!permission) throw new NotFoundException(item_not_found(Entities.Permission));
    return permission;
  }
}
