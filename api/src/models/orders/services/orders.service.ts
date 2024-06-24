import {
  ForbiddenException,
  Inject,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { ORDER_TYPES } from '../interfaces/type';
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Order } from '../entities/order.entity';
import { IOrderRepository } from '../interfaces/repositories/order.repository.interface';
import { User } from '@models/users/entities/user.entity';
import { IOrdersService } from '../interfaces/services/orders.service.interface';
import { item_not_found } from '@common/constants';
import { Entities, ORDER_STATUS, ROLE } from '@common/enums';
import { ADVANTAGE_TYPES } from '@models/advantages/interfaces/type';
import { IAdvantagesService } from '@models/advantages/interfaces/services/advantages.service.interface';
import { OrderPhotoRepository } from '../repositories/order-photo.repository';
import { IPerson } from '@common/interfaces';
import { PAYMENT_TYPES } from '@models/payments/interfaces/type';
import { UserWalletRepository } from '@models/users/repositories/user-wallet.repository';
import { IPaymentsService } from '@models/payments/interfaces/services/payments.service.interface';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISubOrderRepository } from '@models/sub-orders/interfaces/repositories/sub-order.repository.interface';

@Injectable()
export class OrdersService implements IOrdersService {
  constructor(
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: IOrderRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    private readonly walletRepository: UserWalletRepository,
    @Inject(ADVANTAGE_TYPES.service)
    private readonly advantagesService: IAdvantagesService,
    @Inject(PAYMENT_TYPES.service)
    private readonly paymentsService: IPaymentsService,
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
  ) {}

  async find(): Promise<Order[]> {
    return await this.orderRepository.find();
  }
  async findWaiting(): Promise<Order[]> {
    return await this.orderRepository.findWaiting();
  }

  async findMyOrders(userId: string): Promise<Order[]> {
    return await this.orderRepository.findMyOrder(userId);
  }

  async findMineWithAccepted(userId: string): Promise<Order[]> {
    return await this.orderRepository.findMineWithAccepted(userId);
  }

  async findOne(id: string, person?: IPerson): Promise<Order> {
    if (person && person.role.name === ROLE.USER)
      return await this.findOneForOwner(id, person.id);

    const order = await this.orderRepository.findById(id);
    if (!order) throw new NotFoundException(item_not_found(Entities.Order));
    return order;
  }

  async findOneForOwner(id: string, userId: string): Promise<Order> {
    const order = await this.orderRepository.findByIdForOwner(id, userId);
    if (!order) throw new NotFoundException(item_not_found(Entities.Order));
    return order;
  }

  async findOneWithAdvantages(id: string): Promise<Order> {
    return await this.orderRepository.findOneWithAdvantages(id);
  }

  async create(user: User, dto: CreateOrderDto): Promise<Order> {
    const photo = await this.orderPhotoRepository.uploadPhotoMultiple(
      dto.items,
    );

    const advantages = await this.advantagesService.findInIds(dto.advantages);
    let sum: number = 0;
    advantages.forEach((item) => {
      sum += +item.cost;
    });
    const order = await this.orderRepository.create(
      user,
      photo,
      advantages,
      dto,
    );
    await this.paymentsService.create(order, sum);
    return order;
  }

  async update(
    id: string,
    person: IPerson,
    dto: UpdateOrderDto,
  ): Promise<Order> {
    const order = await this.findOne(id, person);
    if (
      order.status !== ORDER_STATUS.WAITING &&
      order.status !== ORDER_STATUS.READY
    ) {
      throw new ForbiddenException(
        'Can not update order advantages after accept the offer',
      );
    }
    const photo = await this.orderPhotoRepository.uploadPhotoMultiple([]);
    return this.orderRepository.update(order, dto, photo);
  }

  async updateStatus(id: string, status: ORDER_STATUS): Promise<Order> {
    return await this.orderRepository.updateStatus(id, status);
  }

  async countOrdersCompletedForUser(userId: string): Promise<number> {
    return await this.orderRepository.countOrdersCompletedForUser(userId);
  }

  async divisionDone(id: string, cost: number): Promise<Order> {
    await this.paymentsService.setTotal(id, cost);
    return await this.orderRepository.updateStatus(id, ORDER_STATUS.READY);
  }

  async acceptance(id: string): Promise<Order> {
    const order = await this.orderRepository.findById(id);
    if (order.status !== ORDER_STATUS.READY) {
      throw new ForbiddenException(
        'Can not acceptance Done this order because his status is not accepted',
      );
    }
    if (!(await this.walletRepository.check(order.userId, order.payment.cost)))
      throw new ForbiddenException(
        `Can not acceptance Done this order because you do not have order's cost`,
      );
    await this.walletRepository.updatePending(order.userId, order.payment.cost);
    await this.subOrderRepository.setStatusToReady(order.id);
    return this.orderRepository.updateStatus(id, ORDER_STATUS.ACCEPTED);
  }

  cancellation(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.updateStatus(id, ORDER_STATUS.CANCELED);
  }

  async refusal(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    await this.subOrderRepository.refusedForOrder(id);
    return this.orderRepository.updateStatus(id, ORDER_STATUS.REFUSED);
  }

  async delete(id: string): Promise<void> {
    const order = await this.orderRepository.findByIdForDelete(id);
    return this.orderRepository.delete(order);
  }

  async addAdvantagesToOrder(
    id: string,
    dto: AddAdvansToOrderDto,
    user: User,
  ): Promise<void> {
    const order = await this.findOneForOwner(id, user.id);

    if (
      order.status !== ORDER_STATUS.WAITING &&
      order.status !== ORDER_STATUS.READY
    ) {
      throw new ForbiddenException(
        'Can not update order advantages after accept the offer',
      );
    }

    const advantages = await this.advantagesService.findInIds(dto.advantages);
    return await this.orderRepository.addAdvantageToOrder(order, advantages);
  }

  async removeAdvantagesFromOrder(
    id: string,
    advantageId: string,
    user: User,
  ): Promise<void> {
    const order = await this.findOneForOwner(id, user.id);
    if (
      order.status !== ORDER_STATUS.WAITING &&
      order.status !== ORDER_STATUS.READY
    ) {
      throw new ForbiddenException(
        'Can not update order advantages after accept the offer',
      );
    }
    const advantage = await this.advantagesService.findOne(advantageId);
    return this.orderRepository.removeAdvantageFromOrder(order, advantage);
  }
}
