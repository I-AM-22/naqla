import { Role } from '../../../roles';
import { CreateAdminDto, UpdateAdminDto } from '../../dtos';
import { AdminPhoto } from '../../entities/admin-photo.entity';
import { Admin } from '../../entities/admin.entity';

export interface IAdminRepository {
  findAll(withDeleted: boolean): Promise<Admin[]>;

  findById(id: string, withDeleted?: boolean): Promise<Admin>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<Admin>;

  create(dto: CreateAdminDto, photo: AdminPhoto, role: Role): Promise<Admin>;

  update(admin: Admin, dto: UpdateAdminDto, photo: AdminPhoto): Promise<Admin>;

  // recover(admin: Admin): Promise<Admin>;

  remove(admin: Admin): Promise<void>;

  validate(id: string): Promise<Admin>;
}
