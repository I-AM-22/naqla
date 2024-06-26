import { Module } from '@nestjs/common';
import { SuperadminSeederService } from './superadmin.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Permission } from '@models/permissions/entities/permission.entity';
import { Role } from '@models/roles/entities/role.entity';
import { Admin } from '@models/admins/entities/admin.entity';
import { ConfigModule } from '@nestjs/config';
import { SuperAdminInfo } from '@config/app';
import { AdminPhoto } from '@models/admins/entities/admin-photo.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Admin, Permission, Role, AdminPhoto]), ConfigModule.forFeature(SuperAdminInfo)],
  providers: [SuperadminSeederService],
  exports: [SuperadminSeederService],
})
export class SuperadminSeederModule {}
