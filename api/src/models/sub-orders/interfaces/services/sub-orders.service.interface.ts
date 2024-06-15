import { Car } from '../../../drivers/entities/car.entity';
import { CreateSubOrdersDto } from '../../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../../dto/update-sub-order.dto';
import { SubOrder } from '../../entities/sub-order.entity';

export interface ISubOrdersService {
  find(): Promise<SubOrder[]>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]>;
  findOne(id: string): Promise<SubOrder>;
  findTotalCost(id: string): Promise<number>;
  create(dto: CreateSubOrdersDto): Promise<SubOrder[]>;
  update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder>;
  setArrivedAt(id: string): Promise<SubOrder>;
  setPickedUpAt(id: string): Promise<SubOrder>;
  setDeliveredAt(id: string): Promise<SubOrder>;
  ready(id: string): Promise<SubOrder[]>;
  setDriver(subId: string, car: Car): Promise<SubOrder>;
  delete(id: string): Promise<void>;
  deleteForOrder(id: string): Promise<void>;
}
