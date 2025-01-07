import { Module, Provider } from '@nestjs/common';
import { PaymentsService } from './services/payments.service';
import { PAYMENT_TYPES } from './interfaces/type';
import { PaymentRepository } from './repositories/payment.repository';
import { Payment } from './entities/payment.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentsController } from './controllers/payments.controller';

export const PaymentRepositoryProvider: Provider = {
  provide: PAYMENT_TYPES.repository,
  useClass: PaymentRepository,
};

@Module({
  imports: [TypeOrmModule.forFeature([Payment])],
  controllers: [PaymentsController],
  providers: [PaymentsService, PaymentRepository, PaymentRepositoryProvider],
  exports: [PaymentsService, PaymentRepositoryProvider],
})
export class PaymentsModule {}
