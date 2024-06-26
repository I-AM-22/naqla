import { Injectable } from '@nestjs/common';
import { Role } from '@models/roles/entities/role.entity';
import { Repository, Equal } from 'typeorm';
import { ROLE } from '@common/enums';
import { InjectRepository } from '@nestjs/typeorm';
import { IAdminRepository } from '../interfaces/repositories/admin.repository.interface';
import { BaseAuthRepo } from '@common/base';
import { CreateAdminDto, UpdateAdminDto } from '../dtos';
import { AdminPhoto } from '../entities/admin-photo.entity';
import { Admin } from '../entities/admin.entity';

@Injectable()
export class AdminRepository extends BaseAuthRepo<Admin> implements IAdminRepository {
  constructor(
    @InjectRepository(Admin)
    private readonly adminRepository: Repository<Admin>,
  ) {
    super(adminRepository);
  }

  async create(dto: CreateAdminDto, photo: AdminPhoto, role: Role) {
    const admin = this.adminRepository.create({
      ...dto,
      role,
      photos: [photo],
    });
    await this.adminRepository.save(admin);
    return admin;
  }

  async findAll(withDeleted = false) {
    return this.adminRepository.find({
      where: { role: withDeleted ? {} : { name: Equal(ROLE.ADMIN) } },
      withDeleted,
      relations: { photos: true, role: true },
    });
  }

  async update(admin: Admin, dto: UpdateAdminDto, photo?: AdminPhoto) {
    if (photo) admin.photos.push(photo);
    Object.assign(admin, {
      phone: dto.phone,
      name: dto.name,
      password: dto.password,
    });
    await this.adminRepository.save(admin);
    return this.findById(admin.id);
  }

  // async recover(admin: Admin): Promise<Admin> {
  //   return this.adminRepository.recover(admin);
  // }

  async delete(admin: Admin): Promise<void> {
    await this.adminRepository.softRemove(admin);
  }
}
