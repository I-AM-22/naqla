import { LoginAdminDto, CreateAdminDto, UpdateAdminDto } from '../../dtos';
import { Admin } from '../../entities/admin.entity';
import { AuthAdminResponse } from '../auth-admin.interface';

export interface IAdminsService {
  login(dto: LoginAdminDto): Promise<AuthAdminResponse>;

  find(role: string): Promise<Admin[]>;

  findOne(id: string, role?: string): Promise<Admin>;

  create(dto: CreateAdminDto): Promise<Admin>;

  update(id: string, dto: UpdateAdminDto): Promise<Admin>;

  // recover(id: string): Promise<Admin>;

  remove(id: string): Promise<void>;
}
