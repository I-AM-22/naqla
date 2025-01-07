import { BadRequestException, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { item_not_found } from '@common/constants';
import { Entities, SUB_ORDER_STATUS } from '@common/enums';
import { IPhotoRepository } from '@common/interfaces';
import { AddAdvansToCarDto, CreateCarDto, UpdateCarDto } from '../dtos';
import { CarPhoto } from '../entities/car-photo.entity';
import { Car } from '../entities/car.entity';
import { Driver } from '../../drivers/entities/driver.entity';
import { ICarRepository } from '../interfaces/repositories/car.repository.interface';
import { CAR_TYPES } from '../interfaces/type';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISubOrderRepository } from '@models/sub-orders/interfaces/repositories/sub-order.repository.interface';
import { In } from 'typeorm';
import { AdvantagesService } from '@models/advantages/services/advantages.service';
import { OrdersService } from '@models/orders/services/orders.service';

@Injectable()
export class CarsService {
  constructor(
    @Inject(CAR_TYPES.repository.car)
    private readonly carRepository: ICarRepository,
    @Inject(CAR_TYPES.repository.photo)
    private readonly carPhotoRepository: IPhotoRepository<CarPhoto>,
    private readonly advantagesService: AdvantagesService,
    private readonly ordersService: OrdersService,
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
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

  async findMyCarsForOrder(driverId: string, orderId: string): Promise<Car[]> {
    const order = await this.ordersService.findOneWithAdvantages(orderId);
    return this.carRepository.findMyCarsForOrder(driverId, order);
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

    await this.carRepository.update(car, dto, photo);

    if (dto.advantageIds.length) {
      const advantagesToInsert = await this.advantagesService.findInIds(dto.advantageIds);

      await this.carRepository.removeAdvantageFromCar(car, car.advantages);

      await this.carRepository.addAdvantageToCar(car, advantagesToInsert);
    }
    return this.findOne(car.id);
  }

  async countCarForDriver(driverId: string): Promise<number> {
    return this.carRepository.countCarForDriver(driverId);
  }

  async delete(id: string, driverId: string): Promise<void> {
    const car = await this.findOneForOwner(id, driverId);
    const subOrders = await this.subOrderRepository.findBy({
      status: In([SUB_ORDER_STATUS.TAKEN, SUB_ORDER_STATUS.ON_THE_WAY]),
      carId: car.id,
    });

    if (subOrders.length) {
      throw new BadRequestException('Can not remove a car that have orders');
    }
    return this.carRepository.delete(car.id);
  }

  async addAdvantagesToCar(id: string, dto: AddAdvansToCarDto, driver: Driver): Promise<void> {
    const car = await this.findOneForOwner(id, driver.id);

    const carAdvantagesIds = car.advantages.map((advantage) => advantage.id);

    const advantagesToInsert = dto.advantages.filter((advantageId) => !carAdvantagesIds.includes(advantageId));

    if (advantagesToInsert.length === 0) {
      return; // No new advantages to add
    }

    const advantages = await this.advantagesService.findInIds(advantagesToInsert);

    await this.carRepository.addAdvantageToCar(car, advantages);
  }

  async removeAdvantagesFromCar(id: string, advantageId: string, driver: Driver): Promise<void> {
    const car = await this.findOneForOwner(id, driver.id);

    const advantage = await this.advantagesService.findOne(advantageId);
    return this.carRepository.removeAdvantageFromCar(car, [advantage]);
  }
}
