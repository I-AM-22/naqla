import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Payment } from '../../payments/entities/payment.entity';
import { Order } from '@models/orders/entities/order.entity';

@Injectable()
export class PaymentRepository {
  constructor(
    @InjectRepository(Payment)
    private readonly paymentRepository: Repository<Payment>,
  ) {}

  async create(order: Order, sum: number): Promise<Payment> {
    const payment = this.paymentRepository.create();
    payment.additionalCost = sum;
    payment.orderId = order.id;
    await this.paymentRepository.save(payment);
    order.paymentId = payment.id;
    await order.save();
    return payment;
  }

  async setTotal(id: string, cost: number): Promise<Payment> {
    const payment = await this.paymentRepository.findOne({
      where: { orderId: id },
    });
    payment.cost = cost;
    return await this.paymentRepository.save(payment);
  }

  async setDeliveredDate(id: string): Promise<Payment> {
    const payment = await this.paymentRepository.findOne({
      where: { orderId: id },
    });

    if (!payment) {
      throw new Error('Payment not found');
    }

    const newDeliveredDate =
      payment.deliveredDate == null ||
      payment.deliveredDate.getTime() < Date.now()
        ? new Date()
        : payment.deliveredDate;

    await this.paymentRepository
      .createQueryBuilder()
      .update(Payment)
      .set({ deliveredDate: newDeliveredDate })
      .where('orderId = :id', { id })
      .execute();

    // استرجاع الدفع بعد التحديث
    const updatedPayment = await this.paymentRepository.findOne({
      where: { orderId: id },
    });

    if (!updatedPayment) {
      throw new NotFoundException('Payment not found after update');
    }

    return updatedPayment;
  }
}
