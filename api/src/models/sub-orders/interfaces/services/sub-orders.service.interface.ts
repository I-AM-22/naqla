import { Order } from '@models/orders/entities/order.entity';
import { CreateSubOrdersDto } from '../../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../../dto/update-sub-order.dto';
import { SubOrder } from '../../entities/sub-order.entity';

export interface ISubOrdersService {
  find(): Promise<SubOrder[]>;
  findForDriver(driverId: string): Promise<SubOrder[]>;
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]>;
  findAllActiveForDriver(driverId: string): Promise<SubOrder[]>;
  findOne(id: string): Promise<SubOrder>;
  findTotalCost(id: string): Promise<number>;
  findByIdForMessage(id: string): Promise<SubOrder>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  create(dto: CreateSubOrdersDto): Promise<Order>;
  update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder>;
  setArrivedAt(id: string): Promise<SubOrder>;
  setPickedUpAt(id: string): Promise<SubOrder>;
  setDeliveredAt(id: string): Promise<SubOrder>;
  setStatusToReady(orderId: string): Promise<SubOrder[]>;
  setDriver(id: string, carId: string): Promise<SubOrder>;
  countSubOrdersCompletedForDriver(driverId: string): Promise<number>;
  refusedForOrder(orderId: string): Promise<void>;
  delete(id: string): Promise<void>;
}
