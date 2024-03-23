import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateOrderDto, UpdateOrderDto } from '../../dtos';
import { Order } from '../../entities/order.entity';
import { IOrderRepository } from '../../interfaces/repositories/order.repository.interface';
import { OrderPhoto } from '../../entities/order-photo.entity';
import { Advantage } from '../../../advantages/entities/advantage.entity';
import { User } from '../../../users';

@Injectable()
export class OrderRepository implements IOrderRepository {
  constructor(
    @InjectRepository(Order)
    private readonly OrderRepository: Repository<Order>,
  ) {}

  async find(): Promise<Order[]> {
    return this.OrderRepository.find({
      select: {
        id: true,
        receiving_date: true,
        cost: true,
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

  async findwaiting(): Promise<Order[]> {
    return this.OrderRepository.find({
      select: {
        id: true,
        receiving_date: true,
        cost: true,
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
      where: { status: 'waiting' },
      relations: { user: true, photos: true, advantages: true },
    });
  }

  async findMyOrder(userId: string): Promise<Order[]> {
    return this.OrderRepository.find({
      where: { userId },
      relations: { advantages: true },
    });
  }

  async findOneForOwner(id: string, userId: string): Promise<Order> {
    return this.OrderRepository.findOne({
      where: { id, userId },
      select: {
        id: true,
        receiving_date: true,
        cost: true,
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
    return this.OrderRepository.findOne({ where: { id } });
  }

  async create(
    user: User,
    photos: OrderPhoto[],
    dto: CreateOrderDto,
  ): Promise<Order> {
    const order = this.OrderRepository.create();
    order.receiving_date = dto.receiving_date;
    order.locationStart = dto.locationStart;
    order.locationEnd = dto.locationEnd;
    order.photos = photos;
    order.user = user;
    order.userId = user.id;
    order.cost = 0;
    order.status = 'waiting';
    return this.OrderRepository.save(order);
  }

  async update(
    user: User,
    order: Order,
    dto: UpdateOrderDto,
    photos: OrderPhoto[],
  ): Promise<Order> {
    order.receiving_date = dto.receiving_date;
    order.locationStart = dto.locationStart;
    order.locationEnd = dto.locationEnd;
    order.status = dto.status;
    order.photos = photos;
    order.userId = user.id;
    order.cost = dto.cost;
    this.OrderRepository.save(Order);

    return this.findOne(order.id);
  }

  async delete(order: Order): Promise<void> {
    await this.OrderRepository.softRemove(order);
  }

  async addAdvantageToOrder(
    order: Order,
    advantages: Advantage[],
  ): Promise<void> {
    await this.OrderRepository.createQueryBuilder()
      .relation(Order, 'advantages')
      .of(order)
      .add(advantages);
  }

  async removeAdvantageFromOrder(
    order: Order,
    advantage: Advantage,
  ): Promise<void> {
    await this.OrderRepository.createQueryBuilder()
      .relation(Order, 'advantages')
      .of(order)
      .remove(advantage);
  }

  // async addPhotoToOrder(order: Order, advantages: Advantage[]): Promise<void> {
  //   await this.OrderRepository.createQueryBuilder()
  //     .relation(Order, 'advantages')
  //     .of(order)
  //     .add(advantages);
  // }

  // async removePhotoFromOrder(order: Order, photo: OrderPhoto): Promise<void> {
  //   await this.OrderRepository.createQueryBuilder()
  //     .relation(Order, 'photo')
  //     .of(order)
  //     .remove(photo);
  // }
}
