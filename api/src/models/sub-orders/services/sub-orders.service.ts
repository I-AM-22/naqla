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

@Injectable()
export class SubOrdersService implements ISubOrdersService {
  constructor(
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: OrderRepository,
    @Inject('ISettingRepository')
    private readonly settingepository: ISettingRepository,
    private readonly gpsDrivingService: GpsDrivingService,
  ) {}

  async create(createSubOrderDto: CreateSubOrderDto): Promise<SubOrder> {
    const pointes = await this.orderRepository.findOne(
      createSubOrderDto.orderId,
    );
    let settingWeight: Setting;
    {
      if (createSubOrderDto.weight < 1000) {
        settingWeight =
          await this.settingepository.findOneByName('defaultWeight');
      } else if (
        createSubOrderDto.weight < 2000 &&
        createSubOrderDto.weight >= 1000
      )
        settingWeight = await this.settingepository.findOneByName('minWeight');
      else if (
        createSubOrderDto.weight < 3000 &&
        createSubOrderDto.weight >= 2000
      )
        settingWeight = await this.settingepository.findOneByName('midWeight');
      else if (createSubOrderDto.weight >= 3000)
        settingWeight = await this.settingepository.findOneByName('maxWeight');
    }
    ///تم القسمة على الف لانه ال المسافة ترجع بالمتر من اجل ان اردها الى الكيلو متر واضربها بسعر الفردي لكل كيلو
    const costDistance =
      (+(await this.gpsDrivingService.costDistance(
        pointes.locationStart,
        pointes.locationEnd,
      )) /
        1000) *
      +settingWeight.cost;
    const sub = await this.subOrderRepository.create(
      createSubOrderDto,
      Math.round(costDistance),
    );
    this.orderPhotoRepository.setPhotoSub(createSubOrderDto.photos, sub.id);
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
}
