import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { ORDER_TYPES } from '../interfaces/type';
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Order } from '../entities/order.entity';
import { IOrderRepository } from '../interfaces/repositories/order.repository.interface';
import { User } from '../../users/entities/user.entity';
import { IOrdersService } from '../interfaces/services/ordrs.service.interface';
import { item_not_found } from '../../../common/constants';
import { Entities } from '../../../common/enums';
// import { IPhotosRepository } from '../../../common/interfaces';
// import { OrderPhoto } from '../entities/order-photo.entity';
import { ADVANTAGE_TYPES } from '../../advantages/interfaces/type';
import { IAdvantagesService } from '../../advantages/interfaces/services/advantages.service.interface';
import { OrderPhotoRepository } from '../repositories/order/order-photo.repository';

@Injectable()
export class OrdersService implements IOrdersService {
  constructor(
    @Inject(ORDER_TYPES.repository.order)
    private readonly OrderRepository: IOrderRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ADVANTAGE_TYPES.service)
    private readonly advantagesService: IAdvantagesService,
  ) {}

  async find(): Promise<Order[]> {
    return this.OrderRepository.find();
  }
  async findwaiting(): Promise<Order[]> {
    return this.OrderRepository.findwaiting();
  }

  async findOne(id: string): Promise<Order> {
    const Order = await this.OrderRepository.findOne(id);
    if (!Order) throw new NotFoundException(item_not_found(Entities.Order));
    return Order;
  }

  async findMyOrders(userId: string): Promise<Order[]> {
    const object = await this.OrderRepository.findMyOrder(userId);
    return object;
  }

  async findOneForOwner(id: string, userId: string): Promise<Order> {
    const order = await this.OrderRepository.findOneForOwner(id, userId);
    if (!order) throw new NotFoundException(item_not_found(Entities.Order));
    return order;
  }

  async create(user: User, dto: CreateOrderDto): Promise<Order> {
    const photo = await this.orderPhotoRepository.uploadPhotoMulti(dto.photo);
    return this.OrderRepository.create(user, photo, dto);
  }

  async update(id: string, user: User, dto: UpdateOrderDto): Promise<Order> {
    const order = await this.findOneForOwner(id, user.id);
    const photo = await this.orderPhotoRepository.uploadPhotoMulti(dto.photo);
    return this.OrderRepository.update(user, order, dto, photo);
  }

  async delete(id: string, orderId: string): Promise<void> {
    const order = await this.findOneForOwner(id, orderId);
    return this.OrderRepository.delete(order);
  }

  async addAdvantagesToOrder(
    id: string,
    dto: AddAdvansToOrderDto,
    user: User,
  ): Promise<void> {
    const order = await this.findOneForOwner(id, user.id);
    const advantages = await this.advantagesService.findInIds(dto.advantages);
    return this.OrderRepository.addAdvantageToOrder(order, advantages);
  }

  async removeAdvantagesFromOrder(
    id: string,
    advantageId: string,
    user: User,
  ): Promise<void> {
    const order = await this.findOneForOwner(id, user.id);
    const advantage = await this.advantagesService.findOne(advantageId);
    return this.OrderRepository.removeAdvantageFromOrder(order, advantage);
  }
}
