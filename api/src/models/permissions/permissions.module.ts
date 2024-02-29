import { Module, Provider } from '@nestjs/common';
import { PermissionsService } from './services/permissions.service';
import { PermissionsController } from './controllers/permissions.controller';
import { PermissionRepository } from './repositories/permission.repository';
import { Permission } from './entities/permission.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PERMISSION_TYPES } from './interfaces/type';

export const PermissionsServiceProvider: Provider = {
  provide: PERMISSION_TYPES.service,
  useClass: PermissionsService,
};

export const PermissionRepositoryProvider: Provider = {
  provide: PERMISSION_TYPES.repository,
  useClass: PermissionRepository,
};

@Module({
  imports: [TypeOrmModule.forFeature([Permission])],
  controllers: [PermissionsController],
  providers: [PermissionsServiceProvider, PermissionRepositoryProvider],
  exports: [PermissionsServiceProvider, PermissionRepositoryProvider],
})
export class PermissionsModule {}
