import { Advantage } from '../../../advantages/entities/advantage.entity';
import { UpdateOrderDto } from '../../dtos';
import { CreateOrderDto } from '../../dtos/create-order.dto';
import { OrderPhoto } from '../../entities/order-photo.entity';
import { Order } from '../../entities/order.entity';
import { User } from '../../../users/entities/user.entity';
import { ORDER_STATUS } from '@common/enums';

export interface IOrderRepository {
  find(): Promise<Order[]>;
  findWaiting(): Promise<Order[]>;
  findMyOrder(userId: string): Promise<Order[]>;
  findMineWithAccepted(userId: string): Promise<Order[]>;
  findById(id: string): Promise<Order>;
  findByIdForOwner(id: string, userId: string): Promise<Order>;
  findOneWithAdvantages(id: string): Promise<Order>;
  findByIdForDelete(id: string): Promise<Order>;
  create(
    user: User,
    photo: OrderPhoto[],
    advantages: Advantage[],
    dto: CreateOrderDto,
  ): Promise<Order>;
  update(
    order: Order,
    dto: UpdateOrderDto,
    photo: OrderPhoto[],
  ): Promise<Order>;
  countOrdersCompletedForUser(userId: string): Promise<number>;
  updateStatus(id: string, status: ORDER_STATUS): Promise<Order>;
  delete(order: Order): Promise<void>;
  addAdvantageToOrder(Order: Order, advantages: Advantage[]): Promise<void>;
  removeAdvantageFromOrder(order: Order, advantage: Advantage): Promise<void>;
}
