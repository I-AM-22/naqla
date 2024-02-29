import { Module } from '@nestjs/common';
import { SuperadminService } from './superadmin.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Permission } from '../../../models/permissions';
import { Role } from '../../../models/roles';
import { Admin, AdminPhoto } from '../../../models/admins';
import { ConfigModule } from '@nestjs/config';
import { SuperAdminInfo } from '../../../config/app';

@Module({
  imports: [
    TypeOrmModule.forFeature([Admin, Permission, Role, AdminPhoto]),
    ConfigModule.forFeature(SuperAdminInfo),
  ],
  providers: [SuperadminService],
  exports: [SuperadminService],
})
export class SuperadminModule {}
