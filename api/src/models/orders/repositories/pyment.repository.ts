import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from '../entities/order.entity';
import { Payment } from '../entities/payment.entity';

@Injectable()
export class PymentRepository {
  constructor(
    @InjectRepository(Payment)
    private readonly paymentRepository: Repository<Payment>,
    @InjectRepository(Order)
    private readonly orderRepository: Repository<Order>,
  ) {}

  async create(order: Order, sum: number): Promise<Payment> {
    const payment = this.paymentRepository.create();
    payment.additionalCost = sum;
    payment.orderId = order.id;
    await this.paymentRepository.save(payment);
    order.paymentId = payment.id;
    await this.orderRepository.save(order);
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
    payment.deliveredDate =
      payment.deliveredDate == null
        ? new Date()
        : payment.deliveredDate.getTime() < Date.now()
          ? new Date()
          : payment.deliveredDate;
    return await this.paymentRepository.save(payment);
  }
}
