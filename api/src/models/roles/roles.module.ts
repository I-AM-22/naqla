import { Module, Provider } from '@nestjs/common';
import { RolesController } from './controllers/roles.controller';
import { RolesService } from './services/roles.service';
import { RoleRepository } from './repositories/role.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Role } from './entities/role.entity';
import { PermissionsModule } from '../permissions/permissions.module';
import { ROLE_TYPES } from './interfaces/type';

export const RolesServiceProvider: Provider = {
  provide: ROLE_TYPES.service,
  useClass: RolesService,
};

export const RoleRepositoryProvider: Provider = {
  provide: ROLE_TYPES.repository,
  useClass: RoleRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Role]), PermissionsModule],
  controllers: [RolesController],
  providers: [RolesServiceProvider, RoleRepositoryProvider],
  exports: [RolesServiceProvider, RoleRepositoryProvider],
})
export class RolesModule {}
