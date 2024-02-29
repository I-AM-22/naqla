import { Injectable } from '@nestjs/common';
import { PermissionSeederService } from './permissions';
import { SuperadminService } from './superadmin';
import { RoleSeederService } from './roles';
import { LoggerService } from '../../shared/logger/logger.service';

@Injectable()
export class InitialDatabaseSeeder {
  constructor(
    private readonly logger: LoggerService,
    private readonly permissionSeederService: PermissionSeederService,
    private readonly superadminService: SuperadminService,
    private readonly roleSeederService: RoleSeederService,
  ) {}

  async seed() {
    await this.Roles()
      .then((completed) => {
        this.logger.debug('Seeder', 'Successfully completed seeding roles...');
        Promise.resolve(completed);
      })
      .catch((error) => {
        this.logger.error('Seeder', 'Failed seeding roles...');
        Promise.reject(error);
      });

    await this.Permissions()
      .then((completed) => {
        this.logger.debug(
          'Seeder',
          'Successfully completed seeding permissions...',
        );
        Promise.resolve(completed);
      })
      .catch((error) => {
        this.logger.error('Seeder', 'Failed seeding permissions...');
        Promise.reject(error);
      });

    await this.SuperAdmin()
      .then((completed) => {
        this.logger.debug(
          'Seeder',
          'Successfully completed seeding superadmin...',
        );
        Promise.resolve(completed);
      })
      .catch((error) => {
        this.logger.error('Seeder', 'Failed seeding superadmin...');
        Promise.reject(error);
      });
  }

  async Permissions() {
    return await Promise.all(this.permissionSeederService.create())
      .then((createdPermissions) => {
        // Can also use this.logger.verbose('...');
        this.logger.debug(
          'Seeder',
          'No. of Permissions created : ' +
            // Remove all null values and return only created Permissions.
            createdPermissions.filter(
              (nullValueOrCreatedPermission) => nullValueOrCreatedPermission,
            ).length,
        );
        return Promise.resolve(true);
      })
      .catch((error) => Promise.reject(error));
  }
  async SuperAdmin() {
    return await Promise.resolve(this.superadminService.create())
      .then((createdSuper) => {
        // Can also use this.logger.verbose('...');
        if (!createdSuper)
          this.logger.debug('Seeder', 'super admin already exist');
        else this.logger.debug('Seeder', 'super admin created');
        return Promise.resolve(true);
      })
      .catch((error) => Promise.reject(error));
  }
  async Roles() {
    return await Promise.all(this.roleSeederService.create())
      .then((createdRoles) => {
        // Can also use this.logger.verbose('...');
        this.logger.debug(
          'Seeder',
          'No. of Roles created : ' +
            // Remove all null values and return only created Roles.
            createdRoles.filter(
              (nullValueOrCreatedRole) => nullValueOrCreatedRole,
            ).length,
        );
        return Promise.resolve(true);
      })
      .catch((error) => Promise.reject(error));
  }
}
