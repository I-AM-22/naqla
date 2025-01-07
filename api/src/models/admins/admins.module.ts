import { Module, Provider } from '@nestjs/common';
import { AdminsController } from './controllers/admins.controller';
import { AdminPhotoRepository } from './repositories/admin-photo.repository';
import { AdminRepository } from './repositories/admin.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Admin } from './entities/admin.entity';
import { AdminPhoto } from './entities/admin-photo.entity';
import { ADMIN_TYPES } from './interfaces/type';
import { JwtAdminStrategy } from './strategy/jwt-admin.strategy';
import { RolesModule } from '../roles/roles.module';
import { AdminsService } from './services/admins.service';

export const AdminRepositoryProvider: Provider = {
  provide: ADMIN_TYPES.repository.admin,
  useClass: AdminRepository,
};
export const AdminPhotoRepositoryProvider: Provider = {
  provide: ADMIN_TYPES.repository.photo,
  useClass: AdminPhotoRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Admin, AdminPhoto]), RolesModule],
  controllers: [AdminsController],
  providers: [AdminRepositoryProvider, AdminsService, AdminPhotoRepositoryProvider, JwtAdminStrategy],
  exports: [AdminRepositoryProvider, AdminsService, AdminPhotoRepositoryProvider],
})
export class AdminsModule {}
