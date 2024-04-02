import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateOrderDto, UpdateOrderDto } from '../../dtos';
import { Order } from '../../entities/order.entity';
import { IOrderRepository } from '../../interfaces/repositories/order.repository.interface';
import { OrderPhoto } from '../../entities/order-photo.entity';
import { Advantage } from '../../../advantages/entities/advantage.entity';
import { User } from '../../../users';
import { ORDER_STATUSES } from '../../../../common/enums';

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
        advantages: { name: true },
        user: { id: true, firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
      },
      where: { status: ORDER_STATUSES.WAITING },
      relations: { user: true, photos: true, advantages: true },
    });
  }

  async findMyOrder(userId: string): Promise<Order[]> {
    return this.orderRepository.find({
      where: { userId },
      relations: { advantages: true },
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
        user: { id: true, firstName: true, lastName: true },
        photos: true,
        createdAt: true,
        updatedAt: true,
        advantages: { name: true },
      },
      relations: { user: true, photos: true, advantages: true },
    });
  }

  async findOne(id: string): Promise<Order> {
    return this.orderRepository.findOne({ where: { id } });
  }

  async create(
    user: User,
    photos: OrderPhoto[],
    dto: CreateOrderDto,
  ): Promise<Order> {
    const order = this.orderRepository.create({ photos: [] });
    order.desiredDate = dto.desiredDate;
    order.locationStart = dto.locationStart;
    order.locationEnd = dto.locationEnd;
    order.photos.push(...photos);
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
    this.orderRepository.save(order);

    return this.findOne(order.id);
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

  // async addPhotoToOrder(order: Order, advantages: Advantage[]): Promise<void> {
  //   await this.orderRepository.createQueryBuilder()
  //     .relation(Order, 'advantages')
  //     .of(order)
  //     .add(advantages);
  // }

  // async removePhotoFromOrder(order: Order, photo: OrderPhoto): Promise<void> {
  //   await this.orderRepository.createQueryBuilder()
  //     .relation(Order, 'photo')
  //     .of(order)
  //     .remove(photo);
  // }
}
