import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateCarDto, UpdateCarDto } from '../../dtos';
import { Car } from '../../entities/car.entity';
import { ICarRepository } from '../../interfaces/repositories/car.repository.interface';
import { Driver } from '../../entities/driver.entity';
import { CarPhoto } from '../../entities/car-photo.entity';

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
    });
  }

  async findOneForOwner(id: string, driverId: string): Promise<Car> {
    return this.carRepository.findOne({ where: { id, driverId } });
  }

  async findOne(id: string): Promise<Car> {
    return this.carRepository.findOne({ where: { id } });
  }

  async create(
    driver: Driver,
    photo: CarPhoto,
    dto: CreateCarDto,
  ): Promise<Car> {
    const car = new Car();
    car.model = dto.model;
    car.brand = dto.brand;
    car.color = dto.color;
    car.photo = photo;
    car.driver = driver;

    return this.carRepository.save(car);
  }

  async update(car: Car, dto: UpdateCarDto, photo: CarPhoto): Promise<Car> {
    car.brand = dto.brand;
    car.color = dto.color;
    car.model = dto.model;
    car.photo = photo;
    this.carRepository.save(car);

    return this.findOne(car.id);
  }

  async delete(car: Car): Promise<void> {
    await this.carRepository.softRemove(car);
  }
}
