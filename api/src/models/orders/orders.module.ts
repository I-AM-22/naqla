import { forwardRef, Module, Provider } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Order } from './entities/order.entity';
import { ORDER_TYPES } from './interfaces/type';
import { OrdersService } from './services/orders.service';
import { OrderRepository } from './repositories/order.repository';
import { OrderController } from './controllers/orders.controller';
import { OrderPhotoRepository } from './repositories/order-photo.repository';
import { OrderPhoto } from './entities/order-photo.entity';
import {
  AdvantageRepositoryProvider,
  AdvantagesModule,
} from '../advantages/advantages.module';
import { SettingsModule } from '../settings/settings.module';
import { PymentRepository } from './repositories/pyment.repository';
import { Payment } from './entities/payment.entity';
import { SubOrdersModule } from '../sub-orders/sub-orders.module';

export const OrdersServiceProvider: Provider = {
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
export const PymentRepositoryProvider: Provider = {
  provide: 'PymentRepository',
  useClass: PymentRepository,
};
@Module({
  imports: [
    TypeOrmModule.forFeature([Order, OrderPhoto, Payment]),
    AdvantagesModule,
    SettingsModule,
    forwardRef(() => SubOrdersModule),
  ],
  controllers: [OrderController],
  providers: [
    OrdersServiceProvider,
    OrderRepositoryProvider,
    OrderPhotoRepositoryProvider,
    PymentRepositoryProvider,
    OrdersService,
    PymentRepository,
  ],
  exports: [
    OrderRepositoryProvider,
    OrderPhotoRepositoryProvider,
    OrdersServiceProvider,
    PymentRepositoryProvider,
    OrdersService,
    PymentRepository,
  ],
})
export class OrdersModule {}
