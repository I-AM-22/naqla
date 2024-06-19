import { Car } from '@models/drivers/entities/car.entity';
import { CreateSubOrderDto } from '@models/sub-orders/dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '@models/sub-orders/dto/update-sub-order.dto';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';

export interface ISubOrderRepository {
  find(): Promise<SubOrder[]>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findAllActiveForDriver(driverId: string): Promise<SubOrder[]>;
  refusedForOrder(orderId: string): Promise<boolean>;
  findOne(id: string): Promise<SubOrder>;
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]>;
  findTotalCost(id: string): Promise<number>;
  create(id: string, dto: CreateSubOrderDto, cost: number): Promise<SubOrder>;
  update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder>;
  setArrivedAt(id: string): Promise<SubOrder>;
  setPickedUpAt(id: string): Promise<SubOrder>;
  setDeliveredAt(id: string): Promise<SubOrder>;
  areAllSubOrdersCompleted(orderId: string): Promise<boolean>;
  ready(id: string): Promise<SubOrder[]>;
  setDriver(subId: string, car: Car): Promise<SubOrder>;
  delete(id: string): Promise<void>;
  deleteForOrder(id: string): Promise<void>;
}
