import { Injectable } from '@nestjs/common';
import { ROLE } from '@common/enums';
import { Permission } from '@models/permissions/entities/permission.entity';
import { Repository, Not, And, Equal } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateRoleDto } from '../dtos';
import { Role } from '../entities/role.entity';
import { IRoleRepository } from '../interfaces/repositories/role.repository.interface';

@Injectable()
export class RoleRepository implements IRoleRepository {
  constructor(@InjectRepository(Role) private readonly roleRepo: Repository<Role>) {}

  async create(dto: CreateRoleDto, permissions: Permission[]): Promise<Role> {
    const role = this.roleRepo.create({
      name: dto.name,
      permissions,
    });
    await this.roleRepo.insert(role);
    return role;
  }

  async find(): Promise<Role[]> {
    return this.roleRepo.find({ where: { name: Not(ROLE.SUPER_ADMIN) } });
  }

  async findOne(id: string, withDeleted = false, relations?: string[]): Promise<Role> {
    const role = await this.roleRepo.findOne({
      where: { id, name: Not(ROLE.SUPER_ADMIN) },
      select: {
        id: true,
        name: true,
        permissions: {
          action: true,
          subject: true,
          id: true,
        },
        createdAt: true,
        updatedAt: true,
      },
      withDeleted,
      relations: relations ? relations : { permissions: true },
    });
    return role;
  }

  async findByName(name: string): Promise<Role> {
    const role = await this.roleRepo.findOne({
      where: { name: And(Not(ROLE.SUPER_ADMIN), Equal(name)) },
      select: {
        id: true,
        name: true,
        permissions: {
          action: true,
          subject: true,
          id: true,
        },
        createdAt: true,
        updatedAt: true,
      },
    });
    return role;
  }

  async update(role: Role, permissions: Permission[]): Promise<Role> {
    role.permissions = permissions;
    await role.save();
    return role;
  }

  async addPermissions(role: Role, permissions: Permission[]): Promise<Role> {
    role.permissions.push(...permissions);
    await role.save();
    return this.findOne(role.id);
  }

  async deletePermissions(role: Role, permissions: Permission[]): Promise<Role> {
    await this.roleRepo
      .createQueryBuilder()
      .relation(Role, 'permissions')
      .of(role) // you can use just post id as well
      .remove(permissions);
    return this.findOne(role.id);
  }
}
