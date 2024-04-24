import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { OrderPhoto } from '../entities/order-photo.entity';
import { IPhoto, IPhotoRepository } from '../../../common/interfaces';

@Injectable()
export class OrderPhotoRepository implements IPhotoRepository<OrderPhoto> {
  constructor(
    @InjectRepository(OrderPhoto)
    private readonly orderPhotoRepo: Repository<OrderPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto) {
    return this.orderPhotoRepo.create(params);
  }

  async uploadPhotoMulti(paths: string[]): Promise<OrderPhoto[]> {
    if (!paths) return [];
    const uploaded = await this.cloudinaryService.uploadMultiplePhotos(paths);
    const photos = this.orderPhotoRepo.create(uploaded);
    return photos;
  }
}
