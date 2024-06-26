import { CloudinaryService } from '../../../shared/cloudinary/cloudinary.service';
import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto, IPhotoRepository } from '@common/interfaces';
import { EmployeePhoto } from '../entities/employee-photo.entity';

@Injectable()
export class EmployeePhotoRepository implements IPhotoRepository<EmployeePhoto> {
  constructor(
    @InjectRepository(EmployeePhoto)
    private readonly employeePhotoRepo: Repository<EmployeePhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto): EmployeePhoto {
    return this.employeePhotoRepo.create(params);
  }
  async findPhotosByOwner(ownerId: string): Promise<EmployeePhoto[]> {
    return this.employeePhotoRepo.find({ where: { employeeId: ownerId } });
  }

  async delete(photo: EmployeePhoto): Promise<void> {
    return;
  }

  async uploadPhoto(path: string): Promise<EmployeePhoto> {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.employeePhotoRepo.create({
      ...uploaded,
    });
    return photo;
  }
}
