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
import { User } from '../../users/entities/user.entity';
import { IOrdersService } from '../interfaces/services/orders.service.interface';
import { item_not_found } from '../../../common/constants';
import { Entities, ORDER_STATUS, ROLE } from '../../../common/enums';
// import { IPhotoRepository } from '../../../common/interfaces';
// import { OrderPhoto } from '../entities/order-photo.entity';
import { ADVANTAGE_TYPES } from '../../advantages/interfaces/type';
import { IAdvantagesService } from '../../advantages/interfaces/services/advantages.service.interface';
import { OrderPhotoRepository } from '../repositories/order-photo.repository';
import { IPerson } from '../../../common/interfaces';
import { PymentRepository } from '../repositories/pyment.repository';
import { ISettingRepository } from '../../settings/interfaces/repositories/setting.repository.interface';

@Injectable()
export class OrdersService implements IOrdersService {
  constructor(
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: IOrderRepository,
    @Inject('ISettingRepository')
    private readonly settingepository: ISettingRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ADVANTAGE_TYPES.service)
    private readonly advantagesService: IAdvantagesService,
    @Inject('PymentRepository')
    private readonly pymentRepository: PymentRepository,
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
    if (dto.porters > 0) {
      const settingPorters =
        await this.settingepository.findOneByName('porters');
      sum += +dto.porters * +settingPorters.cost;
    }
    await this.pymentRepository.create(order, sum);
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
  async divisionDone(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.divisionDone(id);
  }
  acceptance(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.acceptance(id);
  }
  cancellation(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.cancellation(id);
  }

  refusal(id: string): Promise<Order> {
    // const order = await this.orderRepository.findOne(id);
    // if (order.status !== ORDER_STATUS.WAITING) {
    //   throw new ForbiddenException(
    //     'Can not division Done this order becouss him status is not waiting',
    //   );
    // }
    return this.orderRepository.refusal(id);
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
