import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { item_not_found } from '../../../common/constants';
import { Entities } from '../../../common/enums';
import { IPhotoRepository } from '../../../common/interfaces';
import { IAdvantagesService } from '../../advantages/interfaces/services/advantages.service.interface';
import { ADVANTAGE_TYPES } from '../../advantages/interfaces/type';
import { AddAdvansToCarDto, CreateCarDto, UpdateCarDto } from '../dtos';
import { CarPhoto } from '../entities/car-photo.entity';
import { Car } from '../entities/car.entity';
import { Driver } from '../entities/driver.entity';
import { ICarRepository } from '../interfaces/repositories/car.repository.interface';
import { ICarsService } from '../interfaces/services/cars.service.interface';
import { CAR_TYPES } from '../interfaces/type';

@Injectable()
export class CarsService implements ICarsService {
  constructor(
    @Inject(CAR_TYPES.repository.car)
    private readonly carRepository: ICarRepository,
    @Inject(CAR_TYPES.repository.photo)
    private readonly carPhotoRepository: IPhotoRepository<CarPhoto>,
    @Inject(ADVANTAGE_TYPES.service)
    private readonly advantagesService: IAdvantagesService,
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
    const advantages = await this.advantagesService.findInIds(dto.advantages);
    return this.carRepository.create(driver, photo, advantages, dto);
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

  async addAdvantagesToCar(
    id: string,
    dto: AddAdvansToCarDto,
    driver: Driver,
  ): Promise<void> {
    const car = await this.findOneForOwner(id, driver.id);
    const advantages = await this.advantagesService.findInIds(dto.advantages);
    return this.carRepository.addAdvantageToCar(car, advantages);
  }

  async removeAdvantagesFromCar(
    id: string,
    advantageId: string,
    driver: Driver,
  ): Promise<void> {
    const car = await this.findOneForOwner(id, driver.id);
    const advantage = await this.advantagesService.findOne(advantageId);
    return this.carRepository.removeAdvantageFromCar(car, advantage);
  }
}
