import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto, IPhotoRepository } from '@common/interfaces';
import { UserPhoto } from '../entities/user-photo.entity';

@Injectable()
export class UserPhotoRepository implements IPhotoRepository<UserPhoto> {
  constructor(
    @InjectRepository(UserPhoto)
    private readonly userPhotoRepo: Repository<UserPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}
  create(params: IPhoto) {
    return this.userPhotoRepo.create(params);
  }

  async findPhotosByOwner(userId: string) {
    return this.userPhotoRepo.find({ where: { userId } });
  }

  async uploadPhoto(path: string) {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.userPhotoRepo.create(uploaded);
    return photo;
  }

  delete(photo: UserPhoto): Promise<void> {
    return;
  }
}
