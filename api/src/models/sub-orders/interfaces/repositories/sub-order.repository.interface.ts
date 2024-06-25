import { PaginatedResponse } from '@common/types';
import { Car } from '@models/cars/entities/car.entity';
import { ResponseTime } from '@models/statics/responses/ResponseTime';
import { CreateSubOrderDto } from '@models/sub-orders/dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '@models/sub-orders/dto/update-sub-order.dto';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';

export interface ISubOrderRepository {
  find(): Promise<SubOrder[]>;
  findChats(
    personId: string,
    page: number,
    limit: number,
  ): Promise<PaginatedResponse<SubOrder>>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findAllActiveForDriver(driverId: string): Promise<SubOrder[]>;
  findById(id: string): Promise<SubOrder>;
  findByIdWithAdvantages(id: string): Promise<SubOrder>;
  findByIdForMessage(id: string, personId: string): Promise<SubOrder>;
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]>;
  findByIdForDelete(id: string): Promise<SubOrder>;
  findTotalCost(id: string): Promise<number>;
  countSubOrdersCompleted(): Promise<number>;
  countSubOrdersActive(): Promise<number>;
  responseTime(): Promise<ResponseTime>;
  create(
    orderId: string,
    dto: CreateSubOrderDto,
    cost: number,
  ): Promise<SubOrder>;
  update(subOrder: SubOrder, dto: UpdateSubOrderDto): Promise<SubOrder>;
  refusedForOrder(orderId: string): Promise<void>;
  setArrivedAt(subOrder: SubOrder): Promise<SubOrder>;
  setPickedUpAt(subOrder: SubOrder): Promise<SubOrder>;
  setDeliveredAt(subOrder: SubOrder): Promise<SubOrder>;
  areAllSubOrdersCompleted(orderId: string): Promise<boolean>;
  setStatusToReady(orderId: string): Promise<SubOrder[]>;
  setDriver(subOrder: SubOrder, car: Car): Promise<SubOrder>;
  countSubOrdersCompletedForDriver(driverId: string): Promise<number>;
  delete(subOrder: SubOrder): Promise<void>;
}
