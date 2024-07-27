import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Payment } from '../../payments/entities/payment.entity';
import { Order } from '@models/orders/entities/order.entity';
import { IPaymentRepository } from '../interfaces/repositories/payment.repository.interface';

@Injectable()
export class PaymentRepository implements IPaymentRepository {
  constructor(
    @InjectRepository(Payment)
    private readonly paymentRepo: Repository<Payment>,
  ) {}

  async create(order: Order, sum: number): Promise<Payment> {
    const payment = this.paymentRepo.create();
    payment.additionalCost = sum;
    payment.orderId = order.id;
    await this.paymentRepo.save(payment);
    order.paymentId = payment.id;
    await order.save();
    return payment;
  }

  async findById(id: string): Promise<Payment> {
    return await this.paymentRepo.findOne({ where: { id }, relations: { order: true } });
  }
  async fineOneByOrderId(orderId: string): Promise<Payment> {
    return await this.paymentRepo.findOne({
      where: { orderId },
    });
  }

  async setTotal(payment: Payment, cost: number): Promise<Payment> {
    payment.cost = cost;
    return await this.paymentRepo.save(payment);
  }

  async setDeliveredDate(payment: Payment): Promise<Payment> {
    const newDeliveredDate =
      payment.deliveredDate == null || payment.deliveredDate.getTime() < Date.now()
        ? new Date()
        : payment.deliveredDate;

    await this.paymentRepo
      .createQueryBuilder()
      .update(Payment)
      .set({ deliveredDate: newDeliveredDate })
      .where('orderId = :id', { id: payment.orderId })
      .execute();

    return this.fineOneByOrderId(payment.orderId);
  }
}
