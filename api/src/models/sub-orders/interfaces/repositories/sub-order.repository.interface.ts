import { Car } from '../../../drivers/entities/car.entity';
import { CreateSubOrderDto } from '../../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../../dto/update-sub-order.dto';
import { SubOrder } from '../../entities/sub-order.entity';

export interface ISubOrderRepository {
  find(): Promise<SubOrder[]>;
  findForOrder(orderId: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findWaiting(): Promise<SubOrder[]>;
  findOne(id: string): Promise<SubOrder>;
  create(dto: CreateSubOrderDto, cost: number): Promise<SubOrder>;
  update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder>;
  ready(id: string): Promise<SubOrder[]>;
  setDriver(idsup: string, icar: Car): Promise<SubOrder>;
  delete(id: string): Promise<void>;
  deleteForOrder(id: string): Promise<void>;
}
