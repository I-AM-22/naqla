import { Injectable } from '@nestjs/common';
import { Role } from '@models/roles/entities/role.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { roles } from './data';

/**
 * Service dealing with role based operations.
 *
 * @class
 */
@Injectable()
export class RoleSeederService {
  /**
   * Create an instance of class.
   *
   * @constructs
   *
   * @param {Repository<Role>} roleRepository
   */
  constructor(
    @InjectRepository(Role)
    private readonly roleRepository: Repository<Role>,
  ) {}
  /**
   * Seed all roles.
   *
   * @function
   */
  create(): Array<Promise<Role>> {
    return roles.map(async (role: any) => {
      return await this.roleRepository
        .findOne({
          where: {
            name: role.name,
          },
        })
        .then(async (dbRole) => {
          // We check if a role already exists.
          // If it does don't create a new one.
          if (dbRole) {
            return Promise.resolve(null);
          }
          return Promise.resolve(
            // or create(role).then(() => { ... });
            await this.roleRepository.save(role),
          );
        })
        .catch((error) => Promise.reject(error));
    });
  }
}
