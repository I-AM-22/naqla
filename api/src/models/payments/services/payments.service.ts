import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { Payment } from '../../payments/entities/payment.entity';
import { Order } from '@models/orders/entities/order.entity';
import { IPaymentsService } from '../interfaces/services/payments.service.interface';
import { PAYMENT_TYPES } from '../interfaces/type';
import { IPaymentRepository } from '../interfaces/repositories/payment.repository.interface';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';

@Injectable()
export class PaymentsService implements IPaymentsService {
  constructor(
    @Inject(PAYMENT_TYPES.repository)
    private readonly paymentRepository: IPaymentRepository,
  ) {}

  async create(order: Order, sum: number): Promise<Payment> {
    return this.paymentRepository.create(order, sum);
  }

  fineOneByOrderId(orderId: string): Promise<Payment> {
    const payment = this.paymentRepository.fineOneByOrderId(orderId);
    if (!payment) {
      throw new NotFoundException(item_not_found(Entities.Payment));
    }
    return payment;
  }

  async setTotal(orderId: string, cost: number): Promise<Payment> {
    const payment = await this.fineOneByOrderId(orderId);

    return this.paymentRepository.setTotal(payment, cost);
  }

  async setDeliveredDate(orderId: string): Promise<Payment> {
    const payment = await this.fineOneByOrderId(orderId);

    const updatedPayment = await this.paymentRepository.setDeliveredDate(payment);

    if (!updatedPayment) {
      throw new NotFoundException('Payment not found after update');
    }

    return updatedPayment;
  }
}
