import { Module } from '@nestjs/common';
import { SuperadminSeederService } from './superadmin.service';
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
  providers: [SuperadminSeederService],
  exports: [SuperadminSeederService],
})
export class SuperadminSeederModule {}
