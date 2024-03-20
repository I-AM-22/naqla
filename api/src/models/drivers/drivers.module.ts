import { Module, Provider } from '@nestjs/common';
import { DriverRepository } from './repositories/driver/driver.repository';
import { DriverPhotosRepository } from './repositories/driver/driver-photos.repository';
import { DriverWalletRepository } from './repositories/driver/driver-wallet.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Driver } from './entities/driver.entity';
import { DriverPhoto } from './entities/driver-photo.entity';
import { DriversController } from './controllers/drivers.controller';
import { DriversService } from './services/drivers.service';
import { CitiesModule } from '../cities/cities.module';
import { CAR_TYPES, DRIVER_TYPES } from './interfaces/type';
import { DriverWallet } from './entities/driver-wallet.entity';
import { RolesModule } from '../roles/roles.module';
import { CarsService } from './services/cars.service';
import { CarRepository } from './repositories/car/car.repository';
import { CarController } from './controllers/cars.controller';
import { CarPhotoRepository } from './repositories/car/car-photo.repository';
import { Car } from './entities/car.entity';
import { CarPhoto } from './entities/car-photo.entity';
import { AdvantagesModule } from '../advantages/advantages.module';

export const DriversServiceProvider: Provider = {
  provide: DRIVER_TYPES.service,
  useClass: DriversService,
};

export const DriverRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.driver,
  useClass: DriverRepository,
};
export const DriverPhotosRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.photos,
  useClass: DriverPhotosRepository,
};

export const DriverWalletRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.wallet,
  useClass: DriverWalletRepository,
};

export const CarsServiceProvider: Provider = {
  provide: CAR_TYPES.service,
  useClass: CarsService,
};

export const CarRepositoryProvider: Provider = {
  provide: CAR_TYPES.repository.car,
  useClass: CarRepository,
};

export const CarPhotoRepositoryProvider: Provider = {
  provide: CAR_TYPES.repository.photo,
  useClass: CarPhotoRepository,
};
@Module({
  imports: [
    TypeOrmModule.forFeature([
      Driver,
      DriverWallet,
      DriverPhoto,
      Car,
      CarPhoto,
    ]),
    RolesModule,
    CitiesModule,
    AdvantagesModule,
  ],
  controllers: [DriversController, CarController],
  providers: [
    DriverPhotosRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
    CarsServiceProvider,
    CarRepositoryProvider,
    CarPhotoRepositoryProvider,
  ],
  exports: [
    DriverPhotosRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
  ],
})
export class DriversModule {}
