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
import { OrderStatsDate } from '@models/statics/class/OrderStatsDate';
import { AdvantageSuper } from '@models/statics/class/AdvantageSuper';
import { StaticProfits } from '@models/statics/class/StaticProfits';

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

  async findMineWithAccepted(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId, status: ORDER_STATUS.READY },
      select: {
        advantages: { id: false, cost: false, name: true },
        subOrders: {
          id: true,
          cost: true,
          weight: true,
          photos: true,
          car: {
            id: true,
            color: true,
            model: true,
            brand: true,
            driver: { id: true, firstName: true, lastName: true },
          },
        },
      },
      relations: {
        photos: true,
        advantages: true,
        payment: true,
        subOrders: { car: { driver: true }, photos: true },
      },
    });
  }

  async findOneWithAdvantages(id: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id },
      select: {
        advantages: { id: true, cost: false, name: true },
      },
      relations: { advantages: true },
    });
  }

  async findByIdForOwner(id: string, userId: string): Promise<Order> {
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

  async findById(id: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id },
      select: {
        id: true,
        status: true,
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
        userId: true,
        user: { firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
        advantages: { name: true },
        payment: { additionalCost: true, cost: true },
      },
      relations: { user: true, photos: true, advantages: true, payment: true },
    });
  }

  async findByIdForDelete(id: string): Promise<Order> {
    return this.orderRepository.findOne({
      where: { id },
      relations: { photos: true, subOrders: { messages: true }, payment: true },
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
    return this.findById(order.id);
  }

  async updateStatus(id: string, status: ORDER_STATUS): Promise<Order> {
    await this.orderRepository.update({ id }, { status });

    return await this.findById(id);
  }

  async delete(order: Order): Promise<void> {
    await this.orderRepository.softRemove(order);
  }

  async countOrdersCompletedForUser(userId: string): Promise<number> {
    const completeOrderCount = await this.orderRepository
      .createQueryBuilder('order')
      .where('order.userId = :userId', { userId })
      .andWhere('order.status = :status', {
        status: ORDER_STATUS.DELIVERED,
      })
      .getCount();

    return completeOrderCount;
  }

  async StaticsOrdersForDate(
    startDate: string,
    endDate: string,
  ): Promise<OrderStatsDate[]> {
    return this.orderRepository
      .createQueryBuilder('order')
      .select('DATE(order.createdAt)', 'day')
      .addSelect(
        "COUNT(CASE WHEN order.status = 'delivered' THEN 1 END)",
        'completedOrders',
      )
      .addSelect('COUNT(id)', 'AllOrders')
      .addSelect(
        "COUNT(CASE WHEN order.status = 'refused' THEN 1 END)",
        'refusedOrders',
      )
      .where('order.createdAt BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
      })
      .groupBy('day')
      .getRawMany<OrderStatsDate>();
  }

  async staticProfits(
    startDate: string,
    endDate: string,
  ): Promise<StaticProfits[]> {
    const rawData = await this.orderRepository
      .createQueryBuilder('order')
      .leftJoinAndSelect('order.payment', 'payment')
      .select('DATE(payment.deliveredDate)', 'day')
      .addSelect('SUM(payment.cost)', 'profits')
      .where('order.status = :status', { status: ORDER_STATUS.DELIVERED })
      .andWhere('payment.deliveredDate BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
      })
      .groupBy('day')
      .getRawMany<StaticProfits>();
    return rawData.map((data) => ({
      day: data.day,
      profits: data.profits * 0.05,
    }));
  }

  async advantageSuper(limit: number): Promise<any[]> {
    return this.orderRepository
      .createQueryBuilder('order')
      .leftJoin('order.advantages', 'advantages')
      .select('advantages.name', 'advantage')
      .addSelect('COUNT(advantages.name)', 'x')
      .groupBy('advantages.name')
      .orderBy('x', 'DESC')
      .getRawMany<AdvantageSuper>();
  }

  async countOrdersCompleted(): Promise<number> {
    const completeOrderCount = await this.orderRepository
      .createQueryBuilder('order')
      .where('order.status = :status', {
        status: ORDER_STATUS.DELIVERED,
      })
      .getCount();

    return completeOrderCount;
  }

  async countOrdersActive(): Promise<number> {
    const count = await this.orderRepository
      .createQueryBuilder('order')
      .where('order.status <> :status', {
        status: ORDER_STATUS.DELIVERED,
      })
      .andWhere('order.status <> :status', {
        status: ORDER_STATUS.WAITING,
      })
      .getCount();
    return count;
  }

  async countOrdersWaiting(): Promise<number> {
    const count = await this.orderRepository
      .createQueryBuilder('order')
      .where('order.status = :status', {
        status: ORDER_STATUS.WAITING,
      })
      .getCount();
    return count;
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
