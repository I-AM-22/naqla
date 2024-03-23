import { Module, Provider } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Order } from './entities/order.entity';
import { ORDER_TYPES } from './interfaces/type';
import { OrdersService } from './services/orders.service';
import { OrderRepository } from './repositories/order/order.repository';
import { OrderController } from './controllers/orders.controller';
import { OrderPhotoRepository } from './repositories/order/order-photo.repository';
import { OrderPhoto } from './entities/order-photo.entity';
import { AdvantagesModule } from '../advantages/advantages.module';

export const OrderServiceProvider: Provider = {
  provide: ORDER_TYPES.service,
  useClass: OrdersService,
};

export const OrderRepositoryProvider: Provider = {
  provide: ORDER_TYPES.repository.order,
  useClass: OrderRepository,
};

export const OrderPhotoRepositoryProvider: Provider = {
  provide: ORDER_TYPES.repository.photo,
  useClass: OrderPhotoRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Order, OrderPhoto]), AdvantagesModule],
  controllers: [OrderController],
  providers: [
    OrderServiceProvider,
    OrderRepositoryProvider,
    OrderPhotoRepositoryProvider,
  ],
  // exports: [OrderRepositoryProvider, OrderPhotoRepositoryProvider],
})
export class OrdersModule {}
