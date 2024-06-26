import { Injectable } from '@nestjs/common';
import { Action, Entities } from '@common/enums';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Permission } from '../entities/permission.entity';
import { IPermissionRepository } from '../interfaces/repositories/permission.repository.interface';

@Injectable()
export class PermissionRepository implements IPermissionRepository {
  constructor(
    @InjectRepository(Permission)
    private readonly permissionRepo: Repository<Permission>,
  ) {}
  async find(permissionsIds?: string[]): Promise<Permission[]> {
    let permissions = this.permissionRepo
      .createQueryBuilder('permission')
      .where('(permission.subject != :subject OR permission.action != :action)', {
        subject: Entities.All,
        action: Action.Manage,
      });
    permissions = permissionsIds ? permissions.andWhereInIds(permissionsIds) : permissions;

    return permissions.getMany();
  }
  async findOne(id: string, withDeleted = false): Promise<Permission> {
    let permission = this.permissionRepo
      .createQueryBuilder('permission')
      .where('(permission.subject != :subject OR permission.action != :action)', {
        subject: Entities.All,
        action: Action.Manage,
      })
      .andWhere('permission.id = :id', { id });
    permission = withDeleted ? permission.withDeleted() : permission;
    return permission.getOne();
  }
}
