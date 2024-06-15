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
import { ISettingRepository } from '@models/settings/interfaces/repositories/setting.repository.interface';
import { IPaymentRepository } from '@models/payments/interfaces/repositories/payment.repository.interface';
import { PAYMENT_TYPES } from '@models/payments/interfaces/type';
import { SETTING_TYPES } from '@models/settings/interfaces/type';
import { UserWalletRepository } from '@models/users/repositories/user-wallet.repository';

@Injectable()
export class OrdersService implements IOrdersService {
  constructor(
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: IOrderRepository,
    @Inject(SETTING_TYPES.repository)
    private readonly settingRepository: ISettingRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    private readonly walletRepository: UserWalletRepository,
    @Inject(ADVANTAGE_TYPES.service)
    private readonly advantagesService: IAdvantagesService,
    @Inject(PAYMENT_TYPES.repository)
    private readonly paymentRepository: IPaymentRepository,
  ) {}

  async find(): Promise<Order[]> {
    return this.orderRepository.find();
  }
  async findWaiting(): Promise<Order[]> {
    return this.orderRepository.findWaiting();
  }

  async findOne(id: string, person: IPerson): Promise<Order> {
    if (person.role.name === ROLE.USER)
      return this.findOneForOwner(id, person.id);

    const order = await this.orderRepository.findOne(id);
    if (!order) throw new NotFoundException(item_not_found(Entities.Order));
    return order;
  }

  async findMyOrders(userId: string): Promise<Order[]> {
    return await this.orderRepository.findMyOrder(userId);
  }

  async findMineForAccepted(userId: string): Promise<Order[]> {
    return await this.orderRepository.findMineForAccepted(userId);
  }

  async findOneForOwner(id: string, userId: string): Promise<Order> {
    const order = await this.orderRepository.findOneForOwner(id, userId);
    if (!order) throw new NotFoundException(item_not_found(Entities.Order));
    return order;
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
    await this.paymentRepository.create(order, sum);
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

  async divisionDone(id: string, cost: number): Promise<Order> {
    await this.paymentRepository.setTotal(id, cost);
    return this.orderRepository.divisionDone(id);
  }

  async acceptance(id: string): Promise<Order> {
    const order = await this.orderRepository.findOne(id);
    if (order.status !== ORDER_STATUS.ACCEPTED) {
      throw new ForbiddenException(
        'Can not acceptance Done this order becouss him status is not accepted',
      );
    }
    if (!(await this.walletRepository.check(order.userId, order.payment.cost)))
      throw new ForbiddenException(
        `Can not acceptance Done this order becouss you do not have order's cost`,
      );
    await this.walletRepository.updatePending(order.userId, order.payment.cost);
    return this.orderRepository.updateStatus(id, ORDER_STATUS.READY);
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

  refusal(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.updateStatus(id, ORDER_STATUS.REFUSED);
  }

  async delete(id: string, person: IPerson): Promise<void> {
    const order = await this.findOne(id, person);
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
