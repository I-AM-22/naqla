import { Injectable } from '@nestjs/common';
import { In, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { OrderPhoto } from '../entities/order-photo.entity';
import { IPhoto, IPhotoRepository } from '@common/interfaces';
import { Item } from '../interfaces/item.inteface';

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

  async uploadPhotoMultiple(items: Item[]): Promise<OrderPhoto[]> {
    if (!items) return [];
    let uploaded = await this.cloudinaryService.uploadMultiplePhotos(items.map((item) => item.photo));

    uploaded = uploaded.map((up, index) => {
      up.weight = items[index].weight;
      up.length = items[index].length;
      up.width = items[index].width;
      return up;
    });

    const photos = this.orderPhotoRepo.create(uploaded);
    return photos;
  }
  async setPhotoSub(photos: string[], id: string): Promise<any> {
    return this.orderPhotoRepo.update({ id: In(photos) }, { subOrderId: id });
  }
}
