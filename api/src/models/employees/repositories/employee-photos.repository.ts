import { CloudinaryService } from './../../../shared/cloudinary/cloudinary.service';
import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { IPhoto, IPhotosRepository } from '../../../common/interfaces';
import { EmployeePhoto } from '../entities/employee-photo.entity';

@Injectable()
export class EmployeePhotosRepository
  implements IPhotosRepository<EmployeePhoto>
{
  constructor(
    @InjectRepository(EmployeePhoto)
    private readonly employeePhotosRepo: Repository<EmployeePhoto>,
    private cloudinaryService: CloudinaryService,
  ) {}

  create(params: IPhoto): EmployeePhoto {
    return this.employeePhotosRepo.create(params);
  }
  async findPhotosByOwner(ownerId: string): Promise<EmployeePhoto[]> {
    return this.employeePhotosRepo.find({ where: { employeeId: ownerId } });
  }

  async remove(photo: EmployeePhoto): Promise<void> {
    return;
  }

  async uploadPhoto(path: string): Promise<EmployeePhoto> {
    if (!path) return;
    const uploaded = await this.cloudinaryService.uploadSinglePhoto(path);
    const photo = this.employeePhotosRepo.create({
      ...uploaded,
    });
    return photo;
  }
}
