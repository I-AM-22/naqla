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
import { DRIVER_TYPES } from './interfaces/type';
import { DriverWallet } from './entities/driver-wallet.entity';
import { RolesModule } from '../roles/roles.module';
import { AdvantagesModule } from '../advantages/advantages.module';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';
import { CarsModule } from '@models/cars/cars.module';

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

@Module({
  imports: [
    TypeOrmModule.forFeature([Driver, DriverWallet, DriverPhoto]),
    forwardRef(() => SubOrdersModule),
    RolesModule,
    CitiesModule,
    AdvantagesModule,
    CarsModule,
  ],
  controllers: [DriversController],
  providers: [
    DriverPhotoRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
    DriverWalletRepository,
  ],
  exports: [
    DriverPhotoRepositoryProvider,
    DriverRepositoryProvider,
    DriverWalletRepositoryProvider,
    DriversServiceProvider,
    DriverWalletRepository,
  ],
})
export class DriversModule {}
