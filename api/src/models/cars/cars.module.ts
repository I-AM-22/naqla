import { forwardRef, Module, Provider } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Car } from './entities/car.entity';
import { CarPhoto } from './entities/car-photo.entity';
import { CarPhotoRepository } from '@models/cars/repositories/car-photo.repository';
import { CAR_TYPES } from './interfaces/type';
import { CarController } from './controllers/cars.controller';
import { CarRepository } from './repositories/car.repository';
import { OrdersModule } from '@models/orders/orders.module';
import { AdvantagesModule } from '@models/advantages/advantages.module';
import { OrderCarController } from './controllers/orders-cars.controller';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';
import { CarsService } from './services/cars.service';

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
    forwardRef(() => SubOrdersModule),
  ],
  controllers: [CarController, OrderCarController],
  providers: [CarRepositoryProvider, CarRepository, CarsService, CarPhotoRepositoryProvider],
  exports: [CarRepository, CarRepositoryProvider, CarsService, CarPhotoRepositoryProvider],
})
export class CarsModule {}
