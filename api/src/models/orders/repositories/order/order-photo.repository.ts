import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CloudinaryService } from '../../../../shared/cloudinary';
import { OrderPhoto } from '../../entities/order-photo.entity';
import { IPhoto } from '../../../../common/interfaces';

@Injectable()
export class OrderPhotoRepository {
  constructor(
    @InjectRepository(OrderPhoto)
    private readonly OrderPhotoRepo: Repository<OrderPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto) {
    return this.OrderPhotoRepo.create(params);
  }

  async uploadPhotoulti(path: string[]): Promise<OrderPhoto[]> {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadMultiplePhotos(path);
    const photo = this.OrderPhotoRepo.create(uploaded);
    return photo;
  }

  remove(photo: OrderPhoto): Promise<void> {
    return;
  }
}
