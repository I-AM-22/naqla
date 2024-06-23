import { Module } from '@nestjs/common';
import { CitiesController } from './controllers/statistics.controller';
import { UsersModule } from '@models/users/users.module';
import { SubOrdersModule } from '../sub-orders/sub-orders.module';
import { DriversModule } from '@models/drivers/drivers.module';
import { OrdersModule } from '@models/orders/orders.module';
import { CarsModule } from '@models/cars/cars.module';

@Module({
  imports: [
    UsersModule,
    SubOrdersModule,
    DriversModule,
    OrdersModule,
    CarsModule,
  ],
  controllers: [CitiesController],
  providers: [],
  exports: [],
})
export class StatisticsModule {}
