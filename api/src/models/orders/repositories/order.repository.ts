import { ORDER_STATUS } from '@common/enums';
import { Advantage } from '@models/advantages/entities/advantage.entity';
import { User } from '@models/users/entities/user.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateOrderDto, UpdateOrderDto } from '../dtos';
import { OrderPhoto } from '../entities/order-photo.entity';
import { Order } from '../entities/order.entity';
import { IOrderRepository } from '../interfaces/repositories/order.repository.interface';

@Injectable()
export class OrderRepository implements IOrderRepository {
  constructor(
    @InjectRepository(Order)
    private readonly orderRepository: Repository<Order>,
  ) {}

  async find(): Promise<Order[]> {
    return this.orderRepository.find({
      select: {
        id: true,
        desiredDate: true,
        locationStart: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        locationEnd: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        user: { id: true, firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
      },
      relations: { user: true, photos: true },
    });
  }

  async findWaiting(): Promise<Order[]> {
    return this.orderRepository.find({
      where: { status: ORDER_STATUS.WAITING },
      select: {
        user: { firstName: true, lastName: true },
        advantages: { id: false, cost: false, name: true },
      },
      relations: { photos: true, advantages: true, user: true },
    });
  }

  async findMyOrder(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId },
      select: {
        advantages: { id: false, cost: false, name: true },
      },
      relations: { photos: true, advantages: true, payment: true },
    });
  }

  async findMineforAccepted(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId, status: ORDER_STATUS.ACCEPTED },
      select: {
        advantages: { id: false, cost: false, name: true },
      },
      relations: { photos: true, advantages: true, payment: true },
    });
  }

  async findOneForOwner(id: string, userId: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id, userId },
      select: {
        id: true,
        desiredDate: true,
        locationStart: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        locationEnd: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        photos: true,
        createdAt: true,
        updatedAt: true,
        advantages: { name: true },
      },
      relations: { user: true, photos: true, advantages: true },
    });
  }

  async findOne(id: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id },
      select: {
        id: true,
        desiredDate: true,
        locationStart: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        locationEnd: {
          longitude: true,
          latitude: true,
          region: true,
          street: true,
        },
        user: { firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
        advantages: { name: true },
        payment: { additionalCost: true },
      },
      relations: { user: true, photos: true, advantages: true, payment: true },
    });
  }

  async create(
    user: User,
    photos: OrderPhoto[],
    advantages: Advantage[],
    dto: CreateOrderDto,
  ): Promise<Order> {
    const order = this.orderRepository.create({ photos: [] });
    order.desiredDate = dto.desiredDate;
    order.locationStart = dto.locationStart;
    order.locationEnd = dto.locationEnd;
    order.porters = dto.porters;
    order.photos.push(...photos);
    order.advantages = advantages;
    order.user = user;
    return this.orderRepository.save(order);
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
    await this.orderRepository.save(order);
    return this.findOne(order.id);
  }
  async divisionDone(id: string): Promise<Order> {
    await this.orderRepository
      .createQueryBuilder()
      .update(Order)
      .set({ status: ORDER_STATUS.ACCEPTED })
      .where('id = :id', { id })
      .execute();
    const updatedOrder = await this.findOne(id);
    if (!updatedOrder) {
      throw new Error('Order not found');
    }
    return updatedOrder;
  }
  async acceptance(id: string): Promise<Order> {
    await this.orderRepository
      .createQueryBuilder()
      .update(Order)
      .set({ status: ORDER_STATUS.READY })
      .where('id = :id', { id })
      .execute();
    const updatedOrder = await this.findOne(id);
    if (!updatedOrder) {
      throw new Error('Order not found');
    }
    return updatedOrder;
  }

  async cancellation(id: string): Promise<Order> {
    const order = await this.findOne(id);
    order.status = ORDER_STATUS.CANCELED;
    await this.orderRepository.save(order);
    return order;
  }

  async refusal(id: string): Promise<Order> {
    await this.orderRepository
      .createQueryBuilder()
      .update(Order)
      .set({ status: ORDER_STATUS.REFUSED })
      .where('id = :id', { id })
      .execute();
    const updatedOrder = await this.findOne(id);
    if (!updatedOrder) {
      throw new Error('Order not found');
    }
    return updatedOrder;
  }

  async delete(order: Order): Promise<void> {
    await this.orderRepository.softRemove(order);
  }

  async addAdvantageToOrder(
    order: Order,
    advantages: Advantage[],
  ): Promise<void> {
    await this.orderRepository
      .createQueryBuilder()
      .relation(Order, 'advantages')
      .of(order)
      .add(advantages);
  }

  async removeAdvantageFromOrder(
    order: Order,
    advantage: Advantage,
  ): Promise<void> {
    await this.orderRepository
      .createQueryBuilder()
      .relation(Order, 'advantages')
      .of(order)
      .remove(advantage);
  }
}
