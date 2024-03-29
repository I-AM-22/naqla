import { AddAdvansToOrderDto, UpdateOrderDto } from '../../dtos';
import { CreateOrderDto } from '../../dtos/create-order.dto';
// import { OrderPhoto } from '../../entities/order-photo.entity';
import { Order } from '../../entities/order.entity';
import { User } from '../../../users/entities/user.entity';

export interface IOrdersService {
  find(): Promise<Order[]>;
  findWaiting(): Promise<Order[]>;
  findMyOrders(userId: string): Promise<Order[]>;
  findOne(id: string): Promise<Order>;
  findOneForOwner(id: string, userId: string): Promise<Order>;
  create(user: User, dto: CreateOrderDto): Promise<Order>;
  update(id: string, user: User, dto: UpdateOrderDto): Promise<Order>;
  delete(id: string, userId: string): Promise<void>;
  addAdvantagesToOrder(
    id: string,
    createAdvantageDto: AddAdvansToOrderDto,
    user: User,
  ): Promise<void>;

  removeAdvantagesFromOrder(
    id: string,
    advantageId: string,
    user: User,
  ): Promise<void>;
}
