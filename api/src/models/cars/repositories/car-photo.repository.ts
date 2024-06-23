import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { CarPhoto } from '../entities/car-photo.entity';
import { IPhoto, IPhotoRepository } from '../../../common/interfaces';

@Injectable()
export class CarPhotoRepository implements IPhotoRepository<CarPhoto> {
  constructor(
    @InjectRepository(CarPhoto)
    private readonly carPhotoRepo: Repository<CarPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto) {
    return this.carPhotoRepo.create(params);
  }

  async uploadPhoto(path: string) {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.carPhotoRepo.create(uploaded);
    return photo;
  }

  delete(photo: CarPhoto): Promise<void> {
    return;
  }
}
