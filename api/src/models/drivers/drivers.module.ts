import { forwardRef, Module, Provider } from '@nestjs/common';
import { DriverRepository } from './repositories/driver/driver.repository';
import { DriverPhotoRepository } from './repositories/driver/driver-photo.repository';
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
import { OrdersModule } from '@models/orders/orders.module';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';

export const DriversServiceProvider: Provider = {
  provide: DRIVER_TYPES.service,
  useClass: DriversService,
};

export const DriverRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.driver,
  useClass: DriverRepository,
};
export const DriverPhotoRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.photo,
  useClass: DriverPhotoRepository,
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
    forwardRef(() => OrdersModule),
    forwardRef(() => SubOrdersModule),
    RolesModule,
    CitiesModule,
    AdvantagesModule,
  ],
  controllers: [DriversController, CarController],
  providers: [
    DriverPhotoRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
    CarsServiceProvider,
    CarRepositoryProvider,
    CarRepository,
    CarPhotoRepositoryProvider,
    CarsService,
    DriverWalletRepository,
  ],
  exports: [
    DriverPhotoRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
    CarsService,
    CarRepository,
    DriverWalletRepository,
  ],
})
export class DriversModule {}
