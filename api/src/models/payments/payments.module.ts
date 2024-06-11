import { Module, Provider } from '@nestjs/common';
import { PaymentsService } from './services/payments.service';
import { PaymentsController } from './payments.controller';
import { PAYMENT_TYPES } from './interfaces/type';
import { PaymentRepository } from './repositories/payment.repository';
import { Payment } from './entities/payment.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

export const PaymentRepositoryProvider: Provider = {
  provide: PAYMENT_TYPES.repository,
  useClass: PaymentRepository,
};

@Module({
  imports: [TypeOrmModule.forFeature([Payment])],
  controllers: [PaymentsController],
  providers: [PaymentsService, PaymentRepository, PaymentRepositoryProvider],
  exports: [PaymentRepositoryProvider],
})
export class PaymentsModule {}
