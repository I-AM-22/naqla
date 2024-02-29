import { Module, Provider } from '@nestjs/common';
import { AdminsController } from './controllers/admins.controller';
import { AdminsService } from './services/admins.service';
import { AdminPhotosRepository } from './repositories/admin-photos.repository';
import { AdminRepository } from './repositories/admin.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Role } from '../roles';
import { Admin } from './entities/admin.entity';
import { AdminPhoto } from './entities/admin-photo.entity';
import { ADMIN_TYPES } from './interfaces/type';
import { RoleRepositoryProvider } from '../roles/roles.module';

export const AdminsServiceProvider: Provider = {
  provide: ADMIN_TYPES.service,
  useClass: AdminsService,
};

export const AdminRepositoryProvider: Provider = {
  provide: ADMIN_TYPES.repository.admin,
  useClass: AdminRepository,
};
export const AdminPhotosRepositoryProvider: Provider = {
  provide: ADMIN_TYPES.repository.admin_photos,
  useClass: AdminPhotosRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Role, Admin, AdminPhoto])],
  controllers: [AdminsController],
  providers: [
    AdminsServiceProvider,
    AdminRepositoryProvider,
    AdminPhotosRepositoryProvider,
    RoleRepositoryProvider,
  ],
  exports: [
    AdminsServiceProvider,
    AdminRepositoryProvider,
    AdminPhotosRepositoryProvider,
  ],
})
export class AdminsModule {}
