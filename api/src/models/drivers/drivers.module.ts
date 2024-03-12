import { Module, Provider } from '@nestjs/common';
import { DriverRepository } from './repositories/driver.repository';
import { DriverPhotosRepository } from './repositories/driver-photos.repository';
import { WalletDriverRepository } from './repositories/driver-wallet.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Driver } from './entities/driver.entity';
import { Wallet } from './entities/wallet.entity';
import { DriverPhoto } from './entities/driver-photo.entity';
import { Role } from '../roles/entities/role.entity';
import { RoleRepository } from '../roles/repositories/role.repository';
import { DriversController } from './controllers/drivers.controller';
import { DriversService } from './services/drivers.service';
import { CitiesModule } from '../cities/cities.module';
import { DRIVER_TYPES } from './interfaces/type';

export const DriversServiceProvider: Provider = {
  provide: DRIVER_TYPES.service,
  useClass: DriversService,
};

export const DriverRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.driver,
  useClass: DriverRepository,
};
export const DriverPhotosRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.driver_photos,
  useClass: DriverPhotosRepository,
};

export const WalletDriverRepositoryProvider: Provider = {
  provide: DRIVER_TYPES.repository.wallet,
  useClass: WalletDriverRepository,
};
@Module({
  imports: [
    TypeOrmModule.forFeature([Driver, Wallet, DriverPhoto, Role]),
    CitiesModule,
  ],
  controllers: [DriversController],
  providers: [
    DriverPhotosRepositoryProvider,
    DriverRepositoryProvider,
    WalletDriverRepositoryProvider,
    DriversServiceProvider,
    RoleRepository,
  ],
  exports: [
    DriverPhotosRepositoryProvider,
    DriverRepositoryProvider,
    WalletDriverRepositoryProvider,
    DriversServiceProvider,
  ],
})
export class DriversModule {}
