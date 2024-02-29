import { Injectable } from '@nestjs/common';
import { UserPhoto } from '..';
import { Repository } from 'typeorm';
import { createBlurHash } from '../../../common/helpers';
import { CloudinaryService } from '../../../shared/cloudinary';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto } from '../../../common/interfaces';

@Injectable()
export class UserPhotosRepository {
  constructor(
    @InjectRepository(UserPhoto)
    private readonly userPhotoRepo: Repository<UserPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}
  create(params: IPhoto) {
    return this.userPhotoRepo.create(params);
  }

  async findPhotosByUser(userId: string) {
    return this.userPhotoRepo.find({ where: { userId } });
  }

  async uploadPhoto(path: string) {
    if (!path) return;
    const blurHash = await createBlurHash(path);
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(blurHash);
    const photo = this.userPhotoRepo.create(uploaded);
    return photo;
  }
}
