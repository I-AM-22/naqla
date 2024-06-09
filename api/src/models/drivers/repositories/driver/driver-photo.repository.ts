import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CloudinaryService } from '../../../../shared/cloudinary';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto } from '../../../../common/interfaces';
import { DriverPhoto } from '../../entities/driver-photo.entity';

@Injectable()
export class DriverPhotoRepository {
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
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.driverPhotoRepo.create(uploaded);
    return photo;
  }
}
