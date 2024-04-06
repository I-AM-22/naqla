import { Advantage } from '../../../advantages/entities/advantage.entity';
import { UpdateCarDto } from '../../dtos';
import { CreateCarDto } from '../../dtos/create-car.dto';
import { CarPhoto } from '../../entities/car-photo.entity';
import { Car } from '../../entities/car.entity';
import { Driver } from '../../entities/driver.entity';

export interface ICarRepository {
  find(): Promise<Car[]>;
  findMyCar(driverId: string): Promise<Car[]>;
  findOne(id: string): Promise<Car>;
  findOneForOwner(id: string, driverId: string): Promise<Car>;
  create(
    driver: Driver,
    photo: CarPhoto,
    advantages: Advantage[],
    dto: CreateCarDto,
  ): Promise<Car>;
  update(car: Car, dto: UpdateCarDto, photo: CarPhoto): Promise<Car>;
  delete(car: Car): Promise<void>;
  addAdvantageToCar(car: Car, advantages: Advantage[]): Promise<void>;

  removeAdvantageFromCar(car: Car, advantage: Advantage): Promise<void>;
}
