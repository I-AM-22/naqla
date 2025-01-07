import { defaultPhotoUrl, incorrect_credentials, item_not_found, password_changed_recently } from '@common/constants';
import { Entities, ROLE } from '@common/enums';
import { IPhotoRepository } from '@common/interfaces';
import { Inject, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { JwtTokenService } from '../../../shared/jwt';
import { CreateAdminDto, LoginAdminDto, UpdateAdminDto } from '../dtos';
import { AdminPhoto } from '../entities/admin-photo.entity';
import { Admin } from '../entities/admin.entity';
import { AuthAdminResponse } from '../interfaces';
import { IAdminRepository } from '../interfaces/repositories/admin.repository.interface';
import { ADMIN_TYPES } from '../interfaces/type';
import { RolesService } from '@models/roles/services/roles.service';

@Injectable()
export class AdminsService {
  constructor(
    @Inject(ADMIN_TYPES.repository.admin)
    private adminRepository: IAdminRepository,
    @Inject(ADMIN_TYPES.repository.photo)
    private adminPhotoRepository: IPhotoRepository<AdminPhoto>,
    private jwtTokenService: JwtTokenService,
    private rolesService: RolesService,
  ) {}

  async login(dto: LoginAdminDto): Promise<AuthAdminResponse> {
    const admin = await this.adminRepository.findOneByPhone(dto.phone);
    if (!admin || !(await admin.verifyHash(admin.password, dto.password))) {
      throw new UnauthorizedException(incorrect_credentials);
    }
    const token = await this.jwtTokenService.signToken(admin.id, Entities.Admin);
    return { token, admin };
  }

  async find(_role: string): Promise<Admin[]> {
    return this.adminRepository.findAll(false);
  }

  async findOne(id: string, role?: string): Promise<Admin> {
    const withDeleted = role === ROLE.SUPER_ADMIN ? true : false;
    const admin = await this.adminRepository.findById(id, withDeleted);
    if (!admin) {
      throw new NotFoundException(item_not_found(Entities.Admin));
    }
    return admin;
  }

  async create(dto: CreateAdminDto): Promise<Admin> {
    const role = await this.rolesService.findByName(ROLE.ADMIN);
    let photo;
    if (dto.photo) photo = await this.adminPhotoRepository.uploadPhoto(dto.photo);
    else photo = await this.adminPhotoRepository.uploadPhoto(defaultPhotoUrl);
    const admin = await this.adminRepository.create(dto, photo, role);
    return admin;
  }

  async update(id: string, dto: UpdateAdminDto): Promise<Admin> {
    const admin = await this.findOne(id);
    const photo = await this.adminPhotoRepository.uploadPhoto(dto.photo);
    dto.password = await admin.generateHash(dto.password);
    return this.adminRepository.update(admin, dto, photo);
  }

  async delete(id: string): Promise<void> {
    await this.findOne(id);
    await this.adminRepository.delete(id);
  }

  async validate(id: string, iat: number): Promise<Admin> {
    const admin = await this.adminRepository.findById(id);

    if (!admin) {
      throw new UnauthorizedException('The user is not here');
    }

    if (admin.isPasswordChanged(iat)) {
      throw new UnauthorizedException(password_changed_recently);
    }

    return admin;
  }
}
