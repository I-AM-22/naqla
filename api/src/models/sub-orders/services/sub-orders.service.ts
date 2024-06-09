import { Inject, Injectable } from '@nestjs/common';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SubOrder } from '../entities/sub-order.entity';
import { ORDER_TYPES } from '@models/orders/interfaces/type';
import { OrderPhotoRepository } from '@models/orders/repositories/order-photo.repository';
import { OrderRepository } from '@models/orders/repositories/order.repository';
import { ISettingRepository } from '@models/settings/interfaces/repositories/setting.repository.interface';
import { GpsDrivingService } from '../../../shared/gpsDriving';
import { Setting } from '@models/settings/entities/setting.entity';
import { Car } from '@models/drivers/entities/car.entity';
import { PymentRepository } from '@models/orders/repositories/pyment.repository';

@Injectable()
export class SubOrdersService implements ISubOrdersService {
  constructor(
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: OrderRepository,
    private readonly paymentRepository: PymentRepository,
    @Inject('ISettingRepository')
    private readonly settingepository: ISettingRepository,
    private readonly gpsDrivingService: GpsDrivingService,
  ) {}

  async create(createSubOrderDto: CreateSubOrderDto): Promise<SubOrder[]> {
    const sub: SubOrder[] = [];
    const pointes = await this.orderRepository.findOne(
      createSubOrderDto.orderId,
    );
    let settingWeight: Setting;
    for (let i = 0; i < createSubOrderDto.subOrders.length; i++) {
      {
        if (createSubOrderDto.subOrders[i].weight < 1000) {
          settingWeight =
            await this.settingepository.findOneByName('defaultWeight');
        } else if (
          createSubOrderDto.subOrders[i].weight < 2000 &&
          createSubOrderDto.subOrders[i].weight >= 1000
        )
          settingWeight =
            await this.settingepository.findOneByName('minWeight');
        else if (
          createSubOrderDto.subOrders[i].weight < 3000 &&
          createSubOrderDto.subOrders[i].weight >= 2000
        )
          settingWeight =
            await this.settingepository.findOneByName('midWeight');
        else if (createSubOrderDto.subOrders[i].weight >= 3000)
          settingWeight =
            await this.settingepository.findOneByName('maxWeight');
      }
      ///تم القسمة على الف لانه ال المسافة ترجع بالمتر من اجل ان اردها الى الكيلو متر واضربها بسعر الفردي لكل كيلو
      const costDistance =
        (+(await this.gpsDrivingService.costDistance(
          pointes.locationStart,
          pointes.locationEnd,
        )) /
          1000) *
        +settingWeight.cost;
      sub.push(
        await this.subOrderRepository.create(
          createSubOrderDto.orderId,
          createSubOrderDto.subOrders[i],
          Math.round(costDistance),
        ),
      );
      this.orderPhotoRepository.setPhotoSub(
        createSubOrderDto.subOrders[i].photos,
        sub[sub.length - 1].id,
      );
    }
    return sub;
  }

  find(): Promise<SubOrder[]> {
    return this.subOrderRepository.find();
  }
  findForDriver(cars: Car[]): Promise<SubOrder[]> {
    return this.subOrderRepository.findForDriver(cars);
  }

  findWaiting(): Promise<SubOrder[]> {
    return this.subOrderRepository.findWaiting();
  }

  findForOrder(idOrder: string): Promise<SubOrder[]> {
    return this.subOrderRepository.findForOrder(idOrder);
  }

  findOne(id: string): Promise<SubOrder> {
    return this.subOrderRepository.findOne(id);
  }

  update(id: string, updateSubOrderDto: UpdateSubOrderDto): Promise<SubOrder> {
    return this.subOrderRepository.update(id, updateSubOrderDto);
  }
  setArrivedAt(id: string): Promise<SubOrder> {
    return this.subOrderRepository.setArrivedAt(id);
  }

  setPickedUpAt(id: string): Promise<SubOrder> {
    return this.subOrderRepository.setPickedUpAt(id);
  }

  async setDeliveredAt(id: string): Promise<SubOrder> {
    const sub = await this.subOrderRepository.setDeliveredAt(id);
    await this.paymentRepository.setDeliveredDate(sub.orderId);
    return sub;
  }

  ready(id: string): Promise<SubOrder[]> {
    return this.subOrderRepository.ready(id);
  }
  setDriver(idsup: string, car: Car): Promise<SubOrder> {
    return this.subOrderRepository.setDriver(idsup, car);
  }

  delete(id: string): Promise<void> {
    return this.subOrderRepository.delete(id);
  }
  deleteForOrder(id: string): Promise<void> {
    return this.subOrderRepository.deleteForOrder(id);
  }
  findTotalCost(id: string): Promise<number> {
    return this.subOrderRepository.findTotalCost(id);
  }
}
