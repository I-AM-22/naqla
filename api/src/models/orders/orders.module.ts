import { forwardRef, Module, Provider } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Order } from './entities/order.entity';
import { ORDER_TYPES } from './interfaces/type';
import { OrdersService } from './services/orders.service';
import { OrderRepository } from './repositories/order.repository';
import { OrderController } from './controllers/orders.controller';
import { OrderPhotoRepository } from './repositories/order-photo.repository';
import { OrderPhoto } from './entities/order-photo.entity';
import { AdvantagesModule } from '../advantages/advantages.module';
import { SettingsModule } from '../settings/settings.module';
import { PaymentsModule } from '@models/payments/payments.module';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';
import { UsersModule } from '@models/users/users.module';

export const OrderRepositoryProvider: Provider = {
  provide: ORDER_TYPES.repository.order,
  useClass: OrderRepository,
};

export const OrderPhotoRepositoryProvider: Provider = {
  provide: ORDER_TYPES.repository.photo,
  useClass: OrderPhotoRepository,
};

@Module({
  imports: [
    TypeOrmModule.forFeature([Order, OrderPhoto]),
    AdvantagesModule,
    SettingsModule,
    PaymentsModule,
    forwardRef(() => SubOrdersModule),
    forwardRef(() => UsersModule),
  ],
  controllers: [OrderController],
  providers: [OrdersService, OrderRepositoryProvider, OrderPhotoRepositoryProvider, OrdersService, OrderRepository],
  exports: [OrderRepositoryProvider, OrderPhotoRepositoryProvider, OrdersService, OrdersService, OrderRepository],
})
export class OrdersModule {}
