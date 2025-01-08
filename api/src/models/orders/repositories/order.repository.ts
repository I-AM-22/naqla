import { ORDER_STATUS } from '@common/enums';
import { Advantage } from '@models/advantages/entities/advantage.entity';
import { AdvantageSuper } from '@models/statics/responses/AdvantageSuper';
import { OrderStatsDate } from '@models/statics/responses/OrderStatsDate';
import { User } from '@models/users/entities/user.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, IsNull, Repository } from 'typeorm';
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
    const orderWaiting = await this.orderRepository.find({
      relations: { photos: true, advantages: true, user: true },
      select: {
        user: { firstName: true, lastName: true },
        advantages: { id: false, cost: false, name: true },
      },
      where: { status: ORDER_STATUS.WAITING, user: { disactiveAt: IsNull() } },
    });
    return orderWaiting;
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
    return await this.orderRepository.find({
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

  async findAllActiveForUser(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId, status: In([ORDER_STATUS.ACCEPTED, ORDER_STATUS.ON_THE_WAY, ORDER_STATUS.WAITING]) },
      select: {
        advantages: { id: false, cost: false, name: true },
      },
      relations: {
        photos: true,
        advantages: true,
        payment: true,
      },
      order: {
        createdAt: 'DESC',
      },
    });
  }

  async findAllDoneForUser(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId, status: In([ORDER_STATUS.DELIVERED, ORDER_STATUS.REFUSED, ORDER_STATUS.CANCELED]) },
      select: {
        advantages: { id: false, cost: false, name: true },
      },
      relations: {
        photos: true,
        advantages: true,
        payment: true,
      },
      order: {
        createdAt: 'DESC',
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
        advantages: { id: true, cost: true, name: true },
        status: true,
      },
      relations: { user: true, photos: true, advantages: true, payment: true },
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
        user: { id: true, firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
        advantages: { id: true, cost: true, name: true },
      },
      relations: { user: true, photos: true, advantages: true, payment: true },
    });
  }

  async create(user: User, photos: OrderPhoto[], advantages: Advantage[], dto: CreateOrderDto): Promise<Order> {
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

  async update(order: Order, dto: UpdateOrderDto, photos: OrderPhoto[]): Promise<Order> {
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

  async delete(id: string): Promise<void> {
    await this.orderRepository.softDelete({ id });
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

  async staticsOrdersForDate(startDate: string, endDate: string): Promise<OrderStatsDate[]> {
    return this.orderRepository
      .createQueryBuilder('order')
      .select('DATE(order.createdAt)', 'day')
      .addSelect('COUNT(CASE WHEN order.status = :delivered THEN 1 END)', 'completedOrders')
      .addSelect('COUNT(order.id)', 'AllOrders')
      .addSelect('COUNT(CASE WHEN order.status in (:refused,:canceled) THEN 1 END)', 'refusedOrders')
      .where('order.createdAt BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
        delivered: ORDER_STATUS.DELIVERED,
        refused: ORDER_STATUS.REFUSED,
        canceled: ORDER_STATUS.CANCELED,
      })
      .groupBy('day')
      .getRawMany<OrderStatsDate>();
  }

  async advantageSuper(): Promise<any[]> {
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
    const order = await this.orderRepository.find({
      where: {
        status: In([ORDER_STATUS.ON_THE_WAY, ORDER_STATUS.ACCEPTED]),
      },
    });
    const orderREADY = await this.orderRepository.find({
      relations: { user: true },
      where: {
        status: ORDER_STATUS.READY,
        user: { disactiveAt: IsNull() },
      },
    });
    return order.length + orderREADY.length;
  }

  async countOrdersWaiting(): Promise<number> {
    const orderRaiting = await this.orderRepository.find({
      relations: { user: true },
      where: {
        status: ORDER_STATUS.WAITING,
        user: { disactiveAt: IsNull() },
      },
    });
    return orderRaiting.length;
  }

  async addAdvantageToOrder(order: Order, advantages: Advantage[]): Promise<void> {
    await this.orderRepository.createQueryBuilder().relation(Order, 'advantages').of(order).add(advantages);
  }

  async removeAdvantageFromOrder(order: Order, advantage: Advantage): Promise<void> {
    await this.orderRepository.createQueryBuilder().relation(Order, 'advantages').of(order).remove(advantage);
  }
}
