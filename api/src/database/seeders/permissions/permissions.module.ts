import { Module } from '@nestjs/common';
import { PermissionSeederService } from './permissions.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Permission } from '../../../models/permissions';
import { Role } from '../../../models/roles';

@Module({
  imports: [TypeOrmModule.forFeature([Permission, Role])],
  providers: [PermissionSeederService],
  exports: [PermissionSeederService],
})
export class PermissionsSeederModule {}
