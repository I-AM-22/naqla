import { Injectable } from '@nestjs/common';
import { UserPhoto } from '..';
import { Repository } from 'typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto, IPhotosRepository } from '../../../common/interfaces';

@Injectable()
export class UserPhotosRepository implements IPhotosRepository<UserPhoto> {
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

  remove(photo: UserPhoto): Promise<void> {
    return;
  }
}
