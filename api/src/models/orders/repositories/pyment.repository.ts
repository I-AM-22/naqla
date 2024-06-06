import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UpdateOrderDto } from '../dtos';
import { Order } from '../entities/order.entity';
import { OrderPhoto } from '../entities/order-photo.entity';
// import { Advantage } from '@models/advantages/entities/advantage.entity';
// import { User } from '@models/users';
import { Payment } from '../entities/payment.entity';

@Injectable()
export class PymentRepository {
  constructor(
    @InjectRepository(Payment)
    private readonly paymentRepository: Repository<Payment>,
    @InjectRepository(Order)
    private readonly orderRepository: Repository<Order>,
  ) {}

  async find(): Promise<Order[]> {
    return this.orderRepository.find();
  }

  async findMyOrder(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId },
      select: {
        advantages: { id: false, cost: false, name: true },
      },
      relations: { photos: true, advantages: true },
    });
  }
  async findOne(id: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id },
    });
  }

  async create(order: Order, sum: number): Promise<Payment> {
    const payment = this.paymentRepository.create();
    payment.additionalCost = sum;
    payment.order = order;
    payment.orderId = order.id;
    return this.paymentRepository.save(payment);
  }

  async update(
    order: Order,
    dto: UpdateOrderDto,
    photos: OrderPhoto[],
  ): Promise<Order> {
    order.desiredDate = dto.desiredDate;
    order.locationStart = dto.locationStart;
    order.locationEnd = dto.locationEnd;
    order.photos.push(...photos);
    this.orderRepository.save(order);
    return this.findOne(order.id);
  }

  async delete(order: Order): Promise<void> {
    await this.orderRepository.softRemove(order);
  }
}
