import { PaginatedResponse } from '@common/types';
import { Car } from '@models/cars/entities/car.entity';
import { ResponseTime } from '@models/statics/responses/ResponseTime';
import { StaticProfits } from '@models/statics/responses/StaticProfits';
import { CreateSubOrderDto } from '@models/sub-orders/dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '@models/sub-orders/dto/update-sub-order.dto';
import { SubOrder } from '@models/sub-orders/entities/sub-order.entity';
import { FindOptionsWhere } from 'typeorm';
import { Rating } from '../rating';

export interface ISubOrderRepository {
  find(): Promise<SubOrder[]>;
  findBy(filter?: FindOptionsWhere<SubOrder>): Promise<SubOrder[]>;
  findChats(personId: string, page: number, limit: number): Promise<PaginatedResponse<SubOrder>>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findAllActiveForDriver(driverId: string): Promise<SubOrder[]>;
  findById(id: string): Promise<SubOrder>;
  findByIdWithAdvantages(id: string): Promise<SubOrder>;
  findByIdForMessage(id: string, personId: string): Promise<SubOrder>;
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]>;
  avgRatingForDriver(driverId: string): Promise<number>;
  allratingForDriver(id: string): Promise<Rating[]> 
  findTotalCost(id: string): Promise<number>;
  countSubOrdersCompleted(): Promise<number>;
  countSubOrdersActive(): Promise<number>;
  responseTime(): Promise<ResponseTime>;
  create(orderId: string, dto: CreateSubOrderDto, cost: number, profit: number): Promise<SubOrder>;
  update(subOrder: SubOrder, dto: UpdateSubOrderDto): Promise<SubOrder>;
  refusedForOrder(orderId: string): Promise<void>;
  setArrivedAt(subOrder: SubOrder): Promise<SubOrder>;
  setPickedUpAt(subOrder: SubOrder): Promise<SubOrder>;
  setDeliveredAt(subOrder: SubOrder): Promise<SubOrder>;
  areAllSubOrdersCompleted(orderId: string): Promise<boolean>;
  setStatusToReady(orderId: string): Promise<SubOrder[]>;
  staticProfits(startDate: string, endDate: string): Promise<StaticProfits[]>;
  setDriver(subOrder: SubOrder, car: Car): Promise<SubOrder>;
  countSubOrdersCompletedForDriver(driverId: string): Promise<number>;
  delete(id: string): Promise<void>;
}
