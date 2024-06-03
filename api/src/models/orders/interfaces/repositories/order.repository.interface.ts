import { Advantage } from '../../../advantages/entities/advantage.entity';
import { UpdateOrderDto } from '../../dtos';
import { CreateOrderDto } from '../../dtos/create-order.dto';
import { OrderPhoto } from '../../entities/order-photo.entity';
import { Order } from '../../entities/order.entity';
import { User } from '../../../users/entities/user.entity';

export interface IOrderRepository {
  find(): Promise<Order[]>;
  findWaiting(): Promise<Order[]>;
  findMyOrder(userId: string): Promise<Order[]>;
  findOne(id: string): Promise<Order>;
  findOneForOwner(id: string, userId: string): Promise<Order>;
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
  divisionDone(id: string): Promise<Order>;
  acceptance(id: string): Promise<Order>;
  cancellation(id: string): Promise<Order>;
  refusal(id: string): Promise<Order>;
  delete(order: Order): Promise<void>;
  addAdvantageToOrder(Order: Order, advantages: Advantage[]): Promise<void>;

  removeAdvantageFromOrder(order: Order, advantage: Advantage): Promise<void>;
}
