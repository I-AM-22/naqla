import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { Payment } from '../../payments/entities/payment.entity';
import { Order } from '@models/orders/entities/order.entity';
import { PAYMENT_TYPES } from '../interfaces/type';
import { IPaymentRepository } from '../interfaces/repositories/payment.repository.interface';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';
import { HyperPayService } from '../../../shared/hyper-pay/hyper-pay.service';

@Injectable()
export class PaymentsService {
  constructor(
    @Inject(PAYMENT_TYPES.repository)
    private readonly paymentRepository: IPaymentRepository,
    private readonly hyperPayService: HyperPayService,
  ) {}

  async create(order: Order, sum: number): Promise<Payment> {
    return this.paymentRepository.create(order, sum);
  }

  async findById(id: string): Promise<Payment> {
    const payment = await this.paymentRepository.findById(id);
    if (!payment) {
      throw new NotFoundException(item_not_found(Entities.Payment));
    }
    return payment;
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

  // async checkPaymentStatus(id: string, userId: string): Promise<Payment> {
  //   const payment = await this.paymentRepository.findById(id);
  //   if (payment.order.userId !== userId) {
  //     throw new NotFoundException(item_not_found(Entities.Payment));
  //   }

  //   if (payment.status === PaymentStatus.pending || payment.status === PaymentStatus.failed) {
  //     const response = await this.hyperPayService.checkPaymentStatus(payment.transactionId, payment.methodType);
  //     if (successRegex.test(response.result.code)) {
  //       payment.status = PaymentStatus.success;
  //     } else if (pendingRegex.test(response.result.code) || waitingRegex.test(response.result.code)) {
  //       payment.status = PaymentStatus.pending;
  //     } else {
  //       payment.status = PaymentStatus.failed;
  //     }
  //     payment.reference = response.result.code;
  //     await payment.save();
  //   }
  //   return payment;
  // }

  // async createCheckout(payment: Payment, methodType: HyperPayMethods, user: User) {
  //   const data = await this.hyperPayService.createCheckout(payment.cost, methodType, payment.id, user);
  //   payment.transactionId = data.id;
  //   payment.reference = data.result.code;
  //   payment.status = PaymentStatus.pending;
  //   payment.methodType = methodType;
  //   await payment.save();
  //   return payment;
  // }

  // async recreate(id: string, user: User): Promise<Payment> {
  //   const payment = await this.findById(id);

  //   if (payment.status !== PaymentStatus.failed) {
  //     throw new NotFoundException(item_not_found(Entities.Payment));
  //   }

  //   const data = await this.hyperPayService.createCheckout(payment.cost, payment.methodType, payment.id, user);
  //   payment.transactionId = data.id;
  //   payment.reference = data.result.code;
  //   payment.status = PaymentStatus.pending;
  //   await payment.save();
  //   return await this.findById(payment.id);
  // }
}
