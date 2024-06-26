import { CreateCarDto } from '../../dtos/create-car.dto';
import { Car } from '../../entities/car.entity';
import { Driver } from '../../../drivers/entities/driver.entity';
import { UpdateCarDto, AddAdvansToCarDto } from '@models/cars/dtos';

export interface ICarsService {
  find(): Promise<Car[]>;
  findMyCars(driverId: string): Promise<Car[]>;
  findOne(id: string): Promise<Car>;
  findMyCarsForOrder(driverId: string, orderId: string): Promise<Car[]>;
  findOneForOwner(id: string, driverId: string): Promise<Car>;
  create(driver: Driver, dto: CreateCarDto): Promise<Car>;
  update(id: string, driverId: string, dto: UpdateCarDto): Promise<Car>;
  delete(id: string, driverId: string): Promise<void>;
  addAdvantagesToCar(id: string, createAdvantageDto: AddAdvansToCarDto, driver: Driver): Promise<void>;
  countCarForDriver(driverId: string): Promise<number>;
  removeAdvantagesFromCar(id: string, advantageId: string, driver: Driver): Promise<void>;
}
