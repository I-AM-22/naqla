import { Inject, Injectable } from '@nestjs/common';
import { Admin, CreateAdminDto, UpdateAdminDto } from '../../../models/admins';
import { Role } from '../../../models/roles';
import { Repository, Equal } from 'typeorm';
import { defaultPhoto } from '../../../common/constants/default-image.constant';
import { ROLE } from '../../../common/enums';
import { InjectRepository } from '@nestjs/typeorm';
import { IAdminRepository } from '../interfaces/repositories/admin.repository.interface';
import { IAdminPhotosRepository } from '../interfaces/repositories/admin-photos.repository.interface';
import { ADMIN_TYPES } from '../interfaces/type';
import { BaseAuthRepo } from '../../../common/entities';

@Injectable()
export class AdminRepository
  extends BaseAuthRepo<Admin>
  implements IAdminRepository
{
  constructor(
    @InjectRepository(Admin)
    private readonly adminRepository: Repository<Admin>,
    @Inject(ADMIN_TYPES.repository.admin_photos)
    private readonly adminPhotosRepository: IAdminPhotosRepository,
  ) {
    super(adminRepository);
  }

  async create(dto: CreateAdminDto, role: Role) {
    const admin = this.adminRepository.create({ ...dto, role, photos: [] });
    admin.photos.push(this.adminPhotosRepository.create(defaultPhoto));
    await admin.save();
    return admin;
  }

  async findAll(withDeleted = false) {
    return this.adminRepository.find({
      where: { role: withDeleted ? {} : { name: Equal(ROLE.ADMIN) } },
      withDeleted,
      relations: { photos: true, role: true },
    });
  }

  async update(admin: Admin, dto: UpdateAdminDto) {
    admin.photos.push(await this.adminPhotosRepository.uploadPhoto(dto.photo));
    Object.assign(admin, {
      email: dto.email,
      name: dto.name,
      password: dto.password,
    });
    await this.adminRepository.save(admin);
    return this.findOneById(admin.id);
  }

  // async recover(admin: Admin): Promise<Admin> {
  //   return this.adminRepository.recover(admin);
  // }

  async remove(admin: Admin): Promise<void> {
    await this.adminRepository.softRemove(admin);
  }
}
