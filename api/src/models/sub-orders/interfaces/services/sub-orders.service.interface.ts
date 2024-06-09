import { Car } from '../../../drivers/entities/car.entity';
import { CreateSubOrderDto } from '../../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../../dto/update-sub-order.dto';
import { SubOrder } from '../../entities/sub-order.entity';
// import { User } from '../../../users/entities/user.entity';
// import { IPerson } from '../../../../common/interfaces';

export interface ISubOrdersService {
  find(): Promise<SubOrder[]>;
  findForOrder(idOrder: string): Promise<SubOrder[]>;
  findForDriver(cars: Car[]): Promise<SubOrder[]>;
  findWaiting(): Promise<SubOrder[]>;
  findOne(id: string): Promise<SubOrder>;
  findTotalCost(id: string): Promise<number>;
  create(dto: CreateSubOrderDto): Promise<SubOrder[]>;
  update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder>;
  setArrivedAt(id: string): Promise<SubOrder>;
  setPickedUpAt(id: string): Promise<SubOrder>;
  setDeliveredAt(id: string): Promise<SubOrder>;
  ready(id: string): Promise<SubOrder[]>;
  setDriver(idsup: string, car: Car): Promise<SubOrder>;
  delete(id: string): Promise<void>;
  deleteForOrder(id: string): Promise<void>;
}
