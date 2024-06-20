import { AddAdvansToOrderDto, UpdateOrderDto } from '../../dtos';
import { CreateOrderDto } from '../../dtos/create-order.dto';
import { Order } from '../../entities/order.entity';
import { User } from '../../../users/entities/user.entity';
import { IPerson } from '../../../../common/interfaces';
import { ORDER_STATUS } from '@common/enums';

export interface IOrdersService {
  find(): Promise<Order[]>;
  findWaiting(): Promise<Order[]>;
  findMyOrders(userId: string): Promise<Order[]>;
  findMineWithAccepted(userId: string): Promise<Order[]>;
  findOne(id: string, person?: IPerson): Promise<Order>;
  findOneForOwner(id: string, userId: string): Promise<Order>;
  findOneWithAdvantages(id: string): Promise<Order>;
  countOrdersCompletedForUser(userId: string): Promise<number>;
  create(user: User, dto: CreateOrderDto): Promise<Order>;
  update(id: string, person: IPerson, dto: UpdateOrderDto): Promise<Order>;
  updateStatus(id: string, status: ORDER_STATUS): Promise<Order>;
  acceptance(id: string): Promise<Order>;
  cancellation(id: string): Promise<Order>;
  divisionDone(id: string, cost: number): Promise<Order>;
  refusal(id: string): Promise<Order>;
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
