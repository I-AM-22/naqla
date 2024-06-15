import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Advantage } from '../../../advantages/entities/advantage.entity';
import { CreateCarDto, UpdateCarDto } from '../../dtos';
import { CarPhoto } from '../../entities/car-photo.entity';
import { Car } from '../../entities/car.entity';
import { Driver } from '../../entities/driver.entity';
import { ICarRepository } from '../../interfaces/repositories/car.repository.interface';
import { Order } from '../../../orders/entities/order.entity';

@Injectable()
export class CarRepository implements ICarRepository {
  constructor(
    @InjectRepository(Car)
    private readonly carRepository: Repository<Car>,
  ) {}

  async find(): Promise<Car[]> {
    return this.carRepository.find({
      select: {
        id: true,
        model: true,
        brand: true,
        color: true,
        driver: { id: true, firstName: true, lastName: true },
        createdAt: true,
        updatedAt: true,
      },
      relations: { driver: true },
    });
  }

  async findMyCar(driverId: string): Promise<Car[]> {
    return this.carRepository.find({
      where: { driverId },
      relations: { advantages: true, photos: true },
    });
  }

  async findMyCarsForOrder(driverId: string, order: Order): Promise<Car[]> {
    const cars = await this.carRepository
      .createQueryBuilder('car')
      .leftJoinAndSelect('car.photos', 'photos')
      .leftJoinAndSelect('car.advantages', 'advantages')
      .where('car.driverId = :driverId', { driverId })
      .select(['car', 'photos', 'advantages.name', 'advantages.id'])
      .getMany();

    let carAdvantagesIds;
    const orderAdvantagesIds = order.advantages.map((adv) => adv.id);

    let carAdvantagesSet;
    return cars.filter((car) => {
      carAdvantagesIds = car.advantages.map((adv) => adv.id);
      carAdvantagesSet = new Set(carAdvantagesIds);
      return orderAdvantagesIds.every((id) => carAdvantagesSet.has(id));
    });
  }

  async findOneForOwner(id: string, driverId: string): Promise<Car> {
    return this.carRepository.findOne({
      where: { id, driverId },
      select: {
        id: true,
        model: true,
        brand: true,
        color: true,
        advantages: { id: true, name: true, cost: true },
        createdAt: true,
        updatedAt: true,
      },
      relations: { advantages: true },
    });
  }

  async findOne(id: string): Promise<Car> {
    return this.carRepository.findOne({ where: { id } });
  }

  async create(
    driver: Driver,
    photo: CarPhoto,
    advantages: Advantage[],
    dto: CreateCarDto,
  ): Promise<Car> {
    const car = new Car();
    car.model = dto.model;
    car.brand = dto.brand;
    car.color = dto.color;
    car.photos = [];
    car.photos.push(photo);
    car.driver = driver;
    car.advantages = advantages;

    return this.carRepository.save(car);
  }

  async update(car: Car, dto: UpdateCarDto, photo: CarPhoto): Promise<Car> {
    car.brand = dto.brand;
    car.color = dto.color;
    car.model = dto.model;
    car.photos.push(photo);
    this.carRepository.save(car);

    return this.findOne(car.id);
  }

  async delete(car: Car): Promise<void> {
    await this.carRepository.softRemove(car);
  }

  async addAdvantageToCar(car: Car, advantages: Advantage[]): Promise<void> {
    await this.carRepository
      .createQueryBuilder()
      .relation(Car, 'advantages')
      .of(car)
      .add(advantages);
  }

  async removeAdvantageFromCar(car: Car, advantage: Advantage): Promise<void> {
    await this.carRepository
      .createQueryBuilder()
      .relation(Car, 'advantages')
      .of(car)
      .remove(advantage);
  }
}
