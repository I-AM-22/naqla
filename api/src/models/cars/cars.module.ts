import { forwardRef, Module, Provider } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from './entities/car.entity';
import { CarPhoto } from './entities/car-photo.entity';
import { CarPhotoRepository } from '@models/cars/repositories/car-photo.repository';
import { CAR_TYPES } from './interfaces/type';
import { CarController } from './controllers/cars.controller';
import { CarsService } from './services/cars.service';
import { CarRepository } from './repositories/car.repository';
import { OrdersModule } from '@models/orders/orders.module';
import { AdvantagesModule } from '@models/advantages/advantages.module';
import { OrderCarController } from './controllers/orders-cars.controller';

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
    TypeOrmModule.forFeature([Car, CarPhoto]),
    AdvantagesModule,
    forwardRef(() => OrdersModule),
  ],
  controllers: [CarController, OrderCarController],
  providers: [
    CarsServiceProvider,
    CarRepositoryProvider,
    CarRepository,
    CarPhotoRepositoryProvider,
  ],
  exports: [
    CarRepository,
    CarsServiceProvider,
    CarRepositoryProvider,
    CarPhotoRepositoryProvider,
  ],
})
export class CarsModule {}
