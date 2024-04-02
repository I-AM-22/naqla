import { AddAdvansToOrderDto, UpdateOrderDto } from '../../dtos';
import { CreateOrderDto } from '../../dtos/create-order.dto';
// import { OrderPhoto } from '../../entities/order-photo.entity';
import { Order } from '../../entities/order.entity';
import { User } from '../../../users/entities/user.entity';
import { IPerson } from '../../../../common/interfaces';

export interface IOrdersService {
  find(): Promise<Order[]>;
  findWaiting(): Promise<Order[]>;
  findMyOrders(userId: string): Promise<Order[]>;
  findOne(id: string, person: IPerson): Promise<Order>;
  findOneForOwner(id: string, userId: string): Promise<Order>;
  create(user: User, dto: CreateOrderDto): Promise<Order>;
  update(id: string, person: IPerson, dto: UpdateOrderDto): Promise<Order>;
  delete(id: string, person: IPerson): Promise<void>;
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
