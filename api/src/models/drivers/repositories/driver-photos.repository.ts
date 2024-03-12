import { Injectable } from '@nestjs/common';
import { DriverPhoto } from '..';
import { Repository } from 'typeorm';
import { createBlurHash } from '../../../common/helpers';
import { CloudinaryService } from '../../../shared/cloudinary';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto } from '../../../common/interfaces';

@Injectable()
export class DriverPhotosRepository {
  constructor(
    @InjectRepository(DriverPhoto)
    private readonly driverPhotoRepo: Repository<DriverPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}
  create(params: IPhoto) {
    return this.driverPhotoRepo.create(params);
  }

  async findPhotosByDriver(driverId: string) {
    return this.driverPhotoRepo.find({ where: { driverId } });
  }

  async uploadPhoto(path: string) {
    if (!path) return;
    const blurHash = await createBlurHash(path);
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(blurHash);
    const photo = this.driverPhotoRepo.create(uploaded);
    return photo;
  }
}
