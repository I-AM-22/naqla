import { Injectable } from '@nestjs/common';
import { AdminPhoto } from '../../../models/admins';
import { Repository } from 'typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { IPhoto, IPhotosRepository } from '../../../common/interfaces';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class AdminPhotosRepository implements IPhotosRepository<AdminPhoto> {
  constructor(
    @InjectRepository(AdminPhoto)
    private readonly adminPhotosRepo: Repository<AdminPhoto>,
    private readonly cloudinaryService: CloudinaryService,
  ) {}

  async findPhotosByOwner(ownerId: string): Promise<AdminPhoto[]> {
    return this.adminPhotosRepo.find({ where: { adminId: ownerId } });
  }

  create(params: IPhoto): AdminPhoto {
    return this.adminPhotosRepo.create(params);
  }

  async uploadPhoto(path: string): Promise<AdminPhoto> {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.adminPhotosRepo.create({
      ...uploaded,
    });
    return photo;
  }

  async remove(photo: AdminPhoto): Promise<void> {}
}
