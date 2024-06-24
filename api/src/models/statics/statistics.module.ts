import { CarsModule } from '@models/cars/cars.module';
import { DriversModule } from '@models/drivers/drivers.module';
import { OrdersModule } from '@models/orders/orders.module';
import { UsersModule } from '@models/users/users.module';
import { Module } from '@nestjs/common';
import { SubOrdersModule } from '../sub-orders/sub-orders.module';
import { StatisticsController } from './controllers/statistics.controller';

@Module({
  imports: [
    UsersModule,
    SubOrdersModule,
    DriversModule,
    OrdersModule,
    CarsModule,
  ],
  controllers: [StatisticsController],
  providers: [],
  exports: [],
})
export class StatisticsModule {}
