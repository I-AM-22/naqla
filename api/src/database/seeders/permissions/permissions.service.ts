import { Injectable } from '@nestjs/common';
import { Permission } from '@models/permissions/entities/permission.entity';
import { In, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { permissions } from './data';
import { Role } from '@models/roles/entities/role.entity';

/**
 * Service dealing with Permission based operations.
 *
 * @class
 */
@Injectable()
export class PermissionSeederService {
  /**
   * Create an instance of class.
   *
   * @constructs
   *
   * @param {Repository<Permission>} permissionRepository
   */
  constructor(
    @InjectRepository(Permission)
    private readonly permissionRepository: Repository<Permission>,
    @InjectRepository(Role)
    private readonly roleRepository: Repository<Role>,
  ) {}
  /**
   * Seed all Permissions.
   *
   * @function
   */
  create(): Array<Promise<Permission>> {
    return permissions.map(async (permission) => {
      return await this.permissionRepository
        .findOne({
          where: {
            action: permission.action,
            subject: permission.subject,
          },
        })
        .then(async (dbPermission) => {
          // We check if a Permission already exists.
          // If it does don't create a new one.
          if (dbPermission) {
            return Promise.resolve(null);
          }
          const roles = permission.roles
            ? await this.roleRepository.findBy({
                name: In(permission.roles),
              })
            : [];
          const per = this.permissionRepository.create({
            action: permission.action,
            subject: permission.subject,
            roles,
          });
          return Promise.resolve(
            // or create(Permission).then(() => { ... });
            await this.permissionRepository.save(per),
          );
        })
        .catch((error) => Promise.reject(error));
    });
  }
}
