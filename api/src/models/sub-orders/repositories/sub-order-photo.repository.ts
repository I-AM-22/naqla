import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CloudinaryService } from '../../../shared/cloudinary';
import { SubOrderPhoto } from '../entities/sub-order-photo.entity';
import { IPhoto, IPhotoRepository } from '../../../common/interfaces';

@Injectable()
export class SubOrderPhotoRepository
  implements IPhotoRepository<SubOrderPhoto>
{
  constructor(
    @InjectRepository(SubOrderPhoto)
    private readonly subOrderPhotoRepo: Repository<SubOrderPhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto) {
    return this.subOrderPhotoRepo.create(params);
  }

  async uploadPhotoMulti(paths: string[]): Promise<SubOrderPhoto[]> {
    if (!paths) return [];
    const uploaded = await this.cloudinaryService.uploadMultiplePhotos(paths);
    const photos = this.subOrderPhotoRepo.create(uploaded);
    return photos;
  }
}
