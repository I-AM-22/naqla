import { Injectable } from '@nestjs/common';
import { AdminPhoto } from '../../../models/admins';
import { Repository } from 'typeorm';
import { createBlurHash } from '../../../common/helpers';
import { CloudinaryService } from '../../../shared/cloudinary';
import { IPhoto } from '../../../common/interfaces';
import { InjectRepository } from '@nestjs/typeorm';
import { IAdminPhotosRepository } from '../interfaces/repositories/admin-photos.repository.interface';

@Injectable()
export class AdminPhotosRepository implements IAdminPhotosRepository {
  constructor(
    @InjectRepository(AdminPhoto)
    private readonly adminPhotosRepo: Repository<AdminPhoto>,
    private readonly cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto): AdminPhoto {
    return this.adminPhotosRepo.create(params);
  }

  async uploadPhoto(path: string): Promise<AdminPhoto> {
    if (!path) return;
    const blurHash = await createBlurHash(path);
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(blurHash);
    const photo = this.adminPhotosRepo.create({
      ...uploaded,
    });
    return photo;
  }
}
