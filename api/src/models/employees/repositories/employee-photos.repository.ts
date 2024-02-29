import { CloudinaryService } from './../../../shared/cloudinary/cloudinary.service';
import { Injectable } from '@nestjs/common';
import { createBlurHash } from '../../../common/helpers';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto } from '../../../common/interfaces';
import { EmployeePhoto } from '../entities/employee-photo.entity';
import { IEmployeePhotosRepository } from '../interfaces/repositories/employee-photos.repository.interface';

@Injectable()
export class EmployeePhotosRepository implements IEmployeePhotosRepository {
  constructor(
    @InjectRepository(EmployeePhoto)
    private readonly employeePhotosRepo: Repository<EmployeePhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto): EmployeePhoto {
    return this.employeePhotosRepo.create(params);
  }

  async uploadPhoto(path: string): Promise<EmployeePhoto> {
    if (!path) return;
    const blurHash = await createBlurHash(path);
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(blurHash);
    const photo = this.employeePhotosRepo.create({
      ...uploaded,
    });
    return photo;
  }
}
