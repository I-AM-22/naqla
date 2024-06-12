import { Inject, Injectable } from '@nestjs/common';
import { CreateSubOrdersDto } from '../dto/create-sub-order.dto';
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
import { IPaymentRepository } from '@models/payments/interfaces/repositories/payment.repository.interface';
import { PAYMENT_TYPES } from '@models/payments/interfaces/type';
import { SETTING_TYPES } from '@models/settings/interfaces/type';
import { SETTING_PROPERTIES } from '@common/enums';

@Injectable()
export class SubOrdersService implements ISubOrdersService {
  constructor(
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ORDER_TYPES.repository.order)
    private readonly orderRepository: OrderRepository,
    @Inject(PAYMENT_TYPES.repository)
    private readonly paymentRepository: IPaymentRepository,
    @Inject(SETTING_TYPES.repository)
    private readonly settingRepository: ISettingRepository,
    private readonly gpsDrivingService: GpsDrivingService,
  ) {}

  async create(CreateSubOrdersDto: CreateSubOrdersDto): Promise<SubOrder[]> {
    const subOrders: SubOrder[] = [];
    const order = await this.orderRepository.findOne(
      CreateSubOrdersDto.orderId,
    );

    const [defaultWeight, minWeight, midWeight, maxWeight, portersSetting] =
      await Promise.all([
        this.settingRepository.findOneByName(SETTING_PROPERTIES.DEFAULT_WEIGHT),
        this.settingRepository.findOneByName(SETTING_PROPERTIES.MIN_WEIGHT),
        this.settingRepository.findOneByName(SETTING_PROPERTIES.MID_WEIGHT),
        this.settingRepository.findOneByName(SETTING_PROPERTIES.MAX_WEIGHT),
        this.settingRepository.findOneByName(SETTING_PROPERTIES.PORTERS),
      ]);

    const distanceInMeters = await this.gpsDrivingService.costDistance(
      order.locationStart,
      order.locationEnd,
    );

    const settings = {
      defaultWeight,
      minWeight,
      midWeight,
      maxWeight,
      portersSetting,
    };

    for (const subOrder of CreateSubOrdersDto.subOrders) {
      let settingWeight: Setting;

      if (subOrder.weight < 1000) {
        settingWeight = settings.defaultWeight;
      } else if (subOrder.weight < 2000) {
        settingWeight = settings.minWeight;
      } else if (subOrder.weight < 3000) {
        settingWeight = settings.midWeight;
      } else {
        settingWeight = settings.maxWeight;
      }

      const costDistance = (distanceInMeters / 1000) * settingWeight.cost;
      const portersCost = order.porters
        ? order.porters * settings.portersSetting.cost * subOrder.weight
        : 0;

      const totalCost =
        portersCost + order.payment.additionalCost + costDistance;

      const newSubOrder = await this.subOrderRepository.create(
        CreateSubOrdersDto.orderId,
        subOrder,
        Math.round(totalCost),
      );

      await this.orderPhotoRepository.setPhotoSub(
        subOrder.photos,
        newSubOrder.id,
      );

      subOrders.push(newSubOrder);
    }

    return subOrders;
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

  findForOrder(orderId: string): Promise<SubOrder[]> {
    return this.subOrderRepository.findForOrder(orderId);
  }
  findIsDoneForDriver(driverId: string): Promise<SubOrder[]> {
    return this.subOrderRepository.findIsDoneForDriver(driverId);
  }

  findOne(subOrderId: string): Promise<SubOrder> {
    return this.subOrderRepository.findOne(subOrderId);
  }

  update(
    subOrderId: string,
    updateSubOrderDto: UpdateSubOrderDto,
  ): Promise<SubOrder> {
    return this.subOrderRepository.update(subOrderId, updateSubOrderDto);
  }

  setArrivedAt(subOrderId: string): Promise<SubOrder> {
    return this.subOrderRepository.setArrivedAt(subOrderId);
  }

  setPickedUpAt(subOrderId: string): Promise<SubOrder> {
    return this.subOrderRepository.setPickedUpAt(subOrderId);
  }

  async setDeliveredAt(subOrderId: string): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository.setDeliveredAt(subOrderId);
    await this.paymentRepository.setDeliveredDate(subOrder.orderId);
    return subOrder;
  }

  ready(subOrderId: string): Promise<SubOrder[]> {
    return this.subOrderRepository.ready(subOrderId);
  }

  setDriver(subOrderId: string, car: Car): Promise<SubOrder> {
    return this.subOrderRepository.setDriver(subOrderId, car);
  }

  delete(subOrderId: string): Promise<void> {
    return this.subOrderRepository.delete(subOrderId);
  }

  deleteForOrder(orderId: string): Promise<void> {
    return this.subOrderRepository.deleteForOrder(orderId);
  }

  findTotalCost(subOrderId: string): Promise<number> {
    return this.subOrderRepository.findTotalCost(subOrderId);
  }
}
