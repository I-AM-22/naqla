import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { IPhoto, IPhotoRepository } from '@common/interfaces';
import { InjectRepository } from '@nestjs/typeorm';
import { AdminPhoto } from '../entities/admin-photo.entity';

@Injectable()
export class AdminPhotoRepository implements IPhotoRepository<AdminPhoto> {
  constructor(
    @InjectRepository(AdminPhoto)
    private readonly adminPhotoRepo: Repository<AdminPhoto>,
    private readonly cloudinaryService: CloudinaryService,
  ) {}

  async findPhotosByOwner(ownerId: string): Promise<AdminPhoto[]> {
    return this.adminPhotoRepo.find({ where: { adminId: ownerId } });
  }

  create(params: IPhoto): AdminPhoto {
    return this.adminPhotoRepo.create(params);
  }

  async uploadPhoto(path: string): Promise<AdminPhoto> {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.adminPhotoRepo.create({
      ...uploaded,
    });
    return photo;
  }

  async delete(photo: AdminPhoto): Promise<void> {}
}
