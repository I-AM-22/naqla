import { Module, Provider } from '@nestjs/common';
import { PermissionsController } from './controllers/permissions.controller';
import { PermissionRepository } from './repositories/permission.repository';
import { Permission } from './entities/permission.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PERMISSION_TYPES } from './interfaces/type';
import { PermissionsService } from './services/permissions.service';

export const PermissionRepositoryProvider: Provider = {
  provide: PERMISSION_TYPES.repository,
  useClass: PermissionRepository,
};

@Module({
  imports: [TypeOrmModule.forFeature([Permission])],
  controllers: [PermissionsController],
  providers: [PermissionsService, PermissionRepositoryProvider],
  exports: [PermissionsService, PermissionRepositoryProvider],
})
export class PermissionsModule {}
