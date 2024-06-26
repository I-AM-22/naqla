import {
  BadRequestException,
  ConflictException,
  Inject,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
} from '@nestjs/common';
import { CreateSubOrdersDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SubOrder } from '../entities/sub-order.entity';
import { ORDER_TYPES } from '@models/orders/interfaces/type';
import { OrderPhotoRepository } from '@models/orders/repositories/order-photo.repository';
import { ISettingRepository } from '@models/settings/interfaces/repositories/setting.repository.interface';
import { Setting } from '@models/settings/entities/setting.entity';
import { PAYMENT_TYPES } from '@models/payments/interfaces/type';
import { SETTING_TYPES } from '@models/settings/interfaces/type';
import { Entities, ORDER_STATUS, SETTING_PROPERTIES } from '@common/enums';
import { DataSource } from 'typeorm';
import { InjectDataSource } from '@nestjs/typeorm';
import { UserWallet } from '@models/users/entities/user-wallet.entity';
import { IPerson, IWalletRepository } from '@common/interfaces';
import { DriverWallet } from '@models/drivers/entities/driver-wallet.entity';
import { GpsDrivingService } from '@shared/gpsDriving';
import { IPaymentsService } from '@models/payments/interfaces/services/payments.service.interface';
import { IOrdersService } from '@models/orders/interfaces/services/orders.service.interface';
import { USER_TYPES } from '@models/users/interfaces/type';
import { DRIVER_TYPES } from '@models/drivers/interfaces/type';
import { Order } from '@models/orders/entities/order.entity';
import { item_not_found } from '@common/constants';
import { CAR_TYPES } from '@models/cars/interfaces/type';
import { ICarsService } from '@models/cars/interfaces/services/cars.service.interface';
import { PaginatedResponse } from '@common/types';

@Injectable()
export class SubOrdersService implements ISubOrdersService {
  constructor(
    @InjectDataSource() private dataSource: DataSource,
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
    @Inject(CAR_TYPES.service)
    private readonly carsService: ICarsService,
    @Inject(ORDER_TYPES.repository.photo)
    private readonly orderPhotoRepository: OrderPhotoRepository,
    @Inject(ORDER_TYPES.service)
    private readonly ordersService: IOrdersService,
    @Inject(PAYMENT_TYPES.service)
    private readonly paymentsService: IPaymentsService,
    @Inject(SETTING_TYPES.repository)
    private readonly settingRepository: ISettingRepository,
    @Inject(USER_TYPES.repository.wallet)
    private readonly userWalletRepository: IWalletRepository<UserWallet>,
    @Inject(DRIVER_TYPES.repository.wallet)
    private readonly driverWalletRepository: IWalletRepository<DriverWallet>,
    private readonly gpsDrivingService: GpsDrivingService,
  ) {}

  async create(CreateSubOrdersDto: CreateSubOrdersDto): Promise<Order> {
    const subOrders: SubOrder[] = [];
    const order = await this.ordersService.findOne(CreateSubOrdersDto.orderId);
    if (order.status !== ORDER_STATUS.WAITING) throw new ConflictException('Already divided');
    const [defaultWeight, minWeight, midWeight, maxWeight, portersSetting] = await Promise.all([
      await this.settingRepository.findOneByName(SETTING_PROPERTIES.DEFAULT_WEIGHT),
      await this.settingRepository.findOneByName(SETTING_PROPERTIES.MIN_WEIGHT),
      await this.settingRepository.findOneByName(SETTING_PROPERTIES.MID_WEIGHT),
      await this.settingRepository.findOneByName(SETTING_PROPERTIES.MAX_WEIGHT),
      await this.settingRepository.findOneByName(SETTING_PROPERTIES.PORTERS),
    ]);

    const distanceInMeters = await this.gpsDrivingService.costDistance(order.locationStart, order.locationEnd);

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
      const portersCost = order.porters ? order.porters * settings.portersSetting.cost * subOrder.weight : 0;

      const totalCost = portersCost + order.payment.additionalCost + costDistance;

      const newSubOrder = await this.subOrderRepository.create(
        CreateSubOrdersDto.orderId,
        subOrder,
        Math.round(totalCost),
      );

      await this.orderPhotoRepository.setPhotoSub(subOrder.photos, newSubOrder.id);

      subOrders.push(newSubOrder);
    }
    const cost = await this.findTotalCost(CreateSubOrdersDto.orderId);
    return await this.ordersService.divisionDone(CreateSubOrdersDto.orderId, cost);
  }

  async find(): Promise<SubOrder[]> {
    return await this.subOrderRepository.find();
  }

  async findChats(person: IPerson, page: number, limit: number): Promise<PaginatedResponse<SubOrder>> {
    return await this.subOrderRepository.findChats(person.id, page, limit);
  }

  async findOne(subOrderId: string): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository.findById(subOrderId);
    if (!subOrder) {
      throw new NotFoundException(item_not_found(Entities.Suborder));
    }
    return subOrder;
  }

  async findForDriver(driverId: string): Promise<SubOrder[]> {
    const cars = await this.carsService.findMyCars(driverId);

    return await this.subOrderRepository.findForDriver(cars);
  }

  async findAllActiveForDriver(driverId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository.findAllActiveForDriver(driverId);
  }

  async findIsDoneForDriver(driverId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository.findIsDoneForDriver(driverId);
  }

  async findForOrder(orderId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository.findForOrder(orderId);
  }

  async findByIdForMessage(subOrderId: string, person: IPerson): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository.findByIdForMessage(subOrderId, person.id);
    if (!subOrder) {
      throw new NotFoundException(item_not_found(Entities.Suborder));
    }
    return subOrder;
  }

  async update(subOrderId: string, updateSubOrderDto: UpdateSubOrderDto): Promise<SubOrder> {
    const subOrder = await this.findOne(subOrderId);
    return this.subOrderRepository.update(subOrder, updateSubOrderDto);
  }

  async setArrivedAt(subOrderId: string): Promise<SubOrder> {
    const subOrder = await this.findOne(subOrderId);
    return this.subOrderRepository.setArrivedAt(subOrder);
  }

  async setPickedUpAt(subOrderId: string): Promise<SubOrder> {
    const subOrder = await this.findOne(subOrderId);
    await this.ordersService.updateStatus(subOrder.orderId, ORDER_STATUS.ON_THE_WAY);
    return this.subOrderRepository.setPickedUpAt(subOrder);
  }

  async setDeliveredAt(subOrderId: string): Promise<SubOrder> {
    const queryRunner = this.dataSource.createQueryRunner();

    await queryRunner.connect();
    await queryRunner.startTransaction();

    try {
      const subOrder = await this.findOne(subOrderId);

      // take the cost from the user wallet
      await this.userWalletRepository.withdrawForDriver(subOrder.order.userId, subOrder.cost);
      // transfer the money to the driver wallet
      await this.driverWalletRepository.deposit(subOrder.car.driverId, subOrder.cost - subOrder.cost * 0.05);

      // Update delivery status for the suborder
      await this.subOrderRepository.setDeliveredAt(subOrder);

      // check if the order has been delivered
      const allSubOrdersCompleted = await this.subOrderRepository.areAllSubOrdersCompleted(subOrder.orderId);
      if (allSubOrdersCompleted) {
        // Update the delivered date for the associated payment
        await this.paymentsService.setDeliveredDate(subOrder.orderId);

        // update the order status to completed
        await this.ordersService.updateStatus(subOrder.orderId, ORDER_STATUS.DELIVERED);
      }

      await queryRunner.commitTransaction();
      return subOrder;
    } catch (error) {
      await queryRunner.rollbackTransaction();
      throw new InternalServerErrorException(`Failed to set delivered at: ${error.message}`);
    } finally {
      await queryRunner.release();
    }
  }

  async setStatusToReady(orderId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository.setStatusToReady(orderId);
  }

  async setDriver(subOrderId: string, carId: string): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository.findByIdWithAdvantages(subOrderId);

    if (!subOrder) {
      throw new NotFoundException(`SubOrder with id ${subOrderId} not found`);
    }

    const requestedFeatures = subOrder.order.advantages.map((feature) => feature.id);
    const car = await this.carsService.findOne(carId);
    const carFeatures = car.advantages.map((advantage) => advantage.id);
    const hasAllFeatures = requestedFeatures.every((feature) => carFeatures.includes(feature));

    if (!hasAllFeatures) {
      throw new BadRequestException(`Car does not have all the requested features`);
    }

    return this.subOrderRepository.setDriver(subOrder, car);
  }

  async countSubOrdersCompletedForDriver(driverId: string): Promise<number> {
    return this.subOrderRepository.countSubOrdersCompletedForDriver(driverId);
  }

  async delete(subOrderId: string): Promise<void> {
    const subOrder = await this.subOrderRepository.findByIdForDelete(subOrderId);
    return await this.subOrderRepository.delete(subOrder);
  }

  async refusedForOrder(orderId: string): Promise<void> {
    return this.subOrderRepository.refusedForOrder(orderId);
  }

  async findTotalCost(subOrderId: string): Promise<number> {
    return await this.subOrderRepository.findTotalCost(subOrderId);
  }
}
