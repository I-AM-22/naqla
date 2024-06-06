import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Role } from '@models/roles/entities/role.entity';
import { RoleSeederService } from './roles.service';

@Module({
  imports: [TypeOrmModule.forFeature([Role])],
  providers: [RoleSeederService],
  exports: [RoleSeederService],
})
export class RolesSeederModule {}
