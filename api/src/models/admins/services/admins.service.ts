import {
  Injectable,
  UnauthorizedException,
  NotFoundException,
  Inject,
} from '@nestjs/common';
import { Entities, ROLE } from '../../../common/enums';
import { CreateAdminDto, LoginAdminDto, UpdateAdminDto } from '../dtos';
import { Admin } from '../entities/admin.entity';
import { AuthAdminResponse } from '../interfaces';
import {
  defaultPhotoUrl,
  incorrect_credentials,
  item_not_found,
  password_changed_recently,
} from '../../../common/constants';
import { IAdminsService } from '../interfaces/services/admins.service.interface';
import { ADMIN_TYPES } from '../interfaces/type';
import { IAdminRepository } from '../interfaces/repositories/admin.repository.interface';
import { JwtTokenService } from '../../../shared/jwt';
import { IRolesService } from '../../roles/interfaces/services/roles.service.interface';
import { ROLE_TYPES } from '../../roles/interfaces/type';
import { IPhotoRepository } from '../../../common/interfaces';
import { AdminPhoto } from '../entities/admin-photo.entity';

@Injectable()
export class AdminsService implements IAdminsService {
  constructor(
    @Inject(ADMIN_TYPES.repository.admin)
    private adminRepository: IAdminRepository,
    @Inject(ADMIN_TYPES.repository.photo)
    private adminPhotoRepository: IPhotoRepository<AdminPhoto>,
    private jwtTokenService: JwtTokenService,
    @Inject(ROLE_TYPES.service)
    private rolesService: IRolesService,
  ) {}

  async login(dto: LoginAdminDto): Promise<AuthAdminResponse> {
    const admin = await this.adminRepository.findOneByPhone(dto.phone);
    if (!admin || !(await admin.verifyHash(admin.password, dto.password))) {
      throw new UnauthorizedException(incorrect_credentials);
    }
    const token = await this.jwtTokenService.signToken(
      admin.id,
      Entities.Admin,
    );
    return { token, admin };
  }

  async find(role: string): Promise<Admin[]> {
    const withDeleted = role === ROLE.SUPER_ADMIN ? true : false;
    return this.adminRepository.findAll(withDeleted);
  }

  async findOne(id: string, role?: string): Promise<Admin> {
    const withDeleted = role === ROLE.SUPER_ADMIN ? true : false;
    const admin = await this.adminRepository.findOneById(id, withDeleted);
    if (!admin) {
      throw new NotFoundException(item_not_found(Entities.Admin));
    }
    return admin;
  }

  async create(dto: CreateAdminDto): Promise<Admin> {
    const role = await this.rolesService.findByName(ROLE.ADMIN);
    let photo;
    if (dto.photo)
      photo = await this.adminPhotoRepository.uploadPhoto(dto.photo);
    else photo = await this.adminPhotoRepository.uploadPhoto(defaultPhotoUrl);
    const admin = await this.adminRepository.create(dto, photo, role);
    return admin;
  }

  async update(id: string, dto: UpdateAdminDto): Promise<Admin> {
    const admin = await this.findOne(id);
    const photo = await this.adminPhotoRepository.uploadPhoto(dto.photo);
    return this.adminRepository.update(admin, dto, photo);
  }

  // async recover(id: string): Promise<Admin> {
  //   const admin = await this.findOne(id);
  //   return this.adminRepository.recover(admin);
  // }

  async remove(id: string): Promise<void> {
    const admin = await this.findOne(id);
    await this.adminRepository.remove(admin);
  }

  async validate(id: string, iat: number): Promise<Admin> {
    const admin = await this.adminRepository.findOneById(id);

    if (!admin) {
      throw new UnauthorizedException('The user is not here');
    }

    if (admin.isPasswordChanged(iat)) {
      throw new UnauthorizedException(password_changed_recently);
    }

    return admin;
  }
}
