import { Module, Provider } from '@nestjs/common';
import { RolesController } from './controllers/roles.controller';
import { RoleRepository } from './repositories/role.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Role } from './entities/role.entity';
import { PermissionsModule } from '../permissions/permissions.module';
import { ROLE_TYPES } from './interfaces/type';
import { RolesService } from './services/roles.service';

export const RoleRepositoryProvider: Provider = {
  provide: ROLE_TYPES.repository,
  useClass: RoleRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Role]), PermissionsModule],
  controllers: [RolesController],
  providers: [RolesService, RoleRepositoryProvider],
  exports: [RolesService, RoleRepositoryProvider],
})
export class RolesModule {}
