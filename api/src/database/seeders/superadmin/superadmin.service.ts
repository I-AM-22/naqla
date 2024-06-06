import { Inject, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Role } from '@models/roles/entities/role.entity';
import { Admin } from '@models/admins/entities/admin.entity';
import { ROLE } from '@common/enums';
import { defaultPhoto } from '@common/constants';
import { SuperAdminInfo } from '@config/app';
import { ConfigType } from '@nestjs/config';
import { AdminPhoto } from '@models/admins/entities/admin-photo.entity';

@Injectable()

/**
 * Service adding superadmin.
 *
 * @class
 */
export class SuperadminSeederService {
  /**
   * Create an instance of class.
   *
   * @constructs
   *
   * @param {Repository<Admin>} adminRepository
   */
  constructor(
    @InjectRepository(Admin)
    private readonly adminRepository: Repository<Admin>,
    @InjectRepository(AdminPhoto)
    private adminPhotoRepository: Repository<AdminPhoto>,
    @InjectRepository(Role)
    private readonly roleRepository: Repository<Role>,
    @Inject(SuperAdminInfo.KEY)
    private superAdminInfo: ConfigType<typeof SuperAdminInfo>,
  ) {}
  /**
   * Seed all Admin.
   *
   * @function
   */
  async create(): Promise<Admin> {
    return await this.adminRepository
      .findOne({
        where: { role: { name: ROLE.SUPER_ADMIN } },
        relations: { role: true },
      })
      .then(async (dbSuper) => {
        // We check if a superadmin already exists.
        // If it does don't create a new one.
        if (dbSuper) {
          return Promise.resolve(null);
        }
        const role = await this.roleRepository.findOneBy({
          name: ROLE.SUPER_ADMIN,
        });
        const admin = this.adminRepository.create({
          firstName: this.superAdminInfo.firstName,
          lastName: this.superAdminInfo.lastName,
          phone: this.superAdminInfo.phone,
          password: this.superAdminInfo.password,
          photos: [],
          role,
        });
        admin.photos.push(this.adminPhotoRepository.create(defaultPhoto));
        return Promise.resolve(
          // or create(superadmin).then(() => { ... });
          await this.adminRepository.save(admin),
        );
      })
      .catch((error) => Promise.reject(error));
  }
}
