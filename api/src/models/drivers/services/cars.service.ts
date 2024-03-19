import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { CAR_TYPES } from '../interfaces/type';
import { CreateCarDto, UpdateCarDto } from '../dtos';
import { Car } from '../entities/car.entity';
import { ICarRepository } from '../interfaces/repositories/car.repository.interface';
import { Driver } from '../entities/driver.entity';
import { ICarsService } from '../interfaces/services/cars.service.interface';
import { item_not_found } from '../../../common/constants';
import { Entities } from '../../../common/enums';
import { IPhotosRepository } from '../../../common/interfaces';
import { CarPhoto } from '../entities/car-photo.entity';

@Injectable()
export class CarsService implements ICarsService {
  constructor(
    @Inject(CAR_TYPES.repository.car)
    private readonly carRepository: ICarRepository,
    @Inject(CAR_TYPES.repository.photo)
    private readonly carPhotoRepository: IPhotosRepository<CarPhoto>,
  ) {}

  async find(): Promise<Car[]> {
    return this.carRepository.find();
  }

  async findOne(id: string): Promise<Car> {
    const car = await this.carRepository.findOne(id);
    if (!car) throw new NotFoundException(item_not_found(Entities.Car));
    return car;
  }

  async findMyCars(driverId: string): Promise<Car[]> {
    return this.carRepository.findMyCar(driverId);
  }

  async findOneForOwner(id: string, driverId: string): Promise<Car> {
    const car = await this.carRepository.findOneForOwner(id, driverId);
    if (!car) throw new NotFoundException(item_not_found(Entities.Car));
    return car;
  }

  async create(driver: Driver, dto: CreateCarDto): Promise<Car> {
    const photo = await this.carPhotoRepository.uploadPhoto(dto.photo);
    return this.carRepository.create(driver, photo, dto);
  }

  async update(id: string, driverId: string, dto: UpdateCarDto): Promise<Car> {
    const car = await this.findOneForOwner(id, driverId);
    const photo = await this.carPhotoRepository.uploadPhoto(dto.photo);
    return this.carRepository.update(car, dto, photo);
  }

  async delete(id: string, driverId: string): Promise<void> {
    const car = await this.findOneForOwner(id, driverId);
    return this.carRepository.delete(car);
  }
}
