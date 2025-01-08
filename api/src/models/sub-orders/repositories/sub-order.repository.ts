import { SUB_ORDER_STATUS } from '@common/enums';
import { PaginatedResponse } from '@common/types';
import { Car } from '@models/cars/entities/car.entity';
import { ResponseTime } from '@models/statics/responses/ResponseTime';
import { StaticProfits } from '@models/statics/responses/StaticProfits';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { FindOptionsWhere, In, Not, Repository } from 'typeorm';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { SubOrder } from '../entities/sub-order.entity';
import { Rating } from '../interfaces/rating';
import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';

@Injectable()
export class SubOrderRepository implements ISubOrderRepository {
  constructor(
    @InjectRepository(SubOrder)
    private readonly subOrderRepository: Repository<SubOrder>,
  ) {}

  async findBy(filter?: FindOptionsWhere<SubOrder>): Promise<SubOrder[]> {
    return await this.subOrderRepository.find({
      where: filter,
      select: {
        order: {
          id: true,
          user: { id: true, firstName: true, lastName: true },
          locationEnd: { latitude: true, longitude: true, region: true, street: true },
          locationStart: { latitude: true, longitude: true, region: true, street: true },
        },
        car: {
          id: true,
          driver: { id: true, firstName: true, lastName: true },
        },
      },
      relations: { order: { user: true }, car: { driver: true } },
    });
  }
  async find(): Promise<SubOrder[]> {
    return this.subOrderRepository.find();
  }

  async findForOrder(orderId: string): Promise<SubOrder[]> {
    const subOrders = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantages')
      .leftJoinAndSelect('subOrder.car', 'car')
      .leftJoinAndSelect('car.driver', 'driver')
      .where('order.id = :orderId', { orderId })
      .select([
        'subOrder',
        'photos',
        'order',
        'advantages.name',
        'advantages.id',
        'car.id',
        'car.model',
        'car.brand',
        'car.color',
        'car.createdAt',
        'car.updatedAt',
        'driver.id',
        'driver.firstName',
        'driver.lastName',
        'driver.createdAt',
        'driver.updatedAt',
      ])
      .getMany();
    return subOrders;
  }

  async findAllActiveForDriver(driverId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.car', 'car')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantages')
      .where('subOrder.status <> :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .andWhere('car.driverId = :driverId', { driverId })
      .select(['subOrder', 'photos', 'order', 'advantages.name'])
      .orderBy('subOrder.driverAssignedAt', 'DESC')
      .getMany();
  }

  async findIsDoneForDriver(driverId: string): Promise<SubOrder[]> {
    return await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.car', 'car')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantages')
      .where('subOrder.status = :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .andWhere('car.driverId = :driverId', { driverId })
      .select(['subOrder', 'photos', 'order', 'advantages.name'])
      .orderBy('subOrder.driverAssignedAt', 'DESC')
      .getMany();
  }
  async avgRatingForDriver(driverId: string): Promise<number> {
    const avgRating = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.car', 'car')
      .where('subOrder.status = :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .andWhere('car.driverId = :driverId', { driverId })
      .andWhere('subOrder.rating <> 0')
      .select('AVG(subOrder.rating)', 'avgRating')
      .getRawOne();
    return avgRating?.avgRating;
  }
  async allratingForDriver(driverId: string): Promise<Rating[]> {
    const x = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('order.user', 'user')
      .leftJoin('subOrder.car', 'car')
      .where('subOrder.status = :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .andWhere('car.driverId = :driverId', { driverId })
      .andWhere('subOrder.rating <> 0 ')
      .andWhere('subOrder.note is not null ')
      .select([
        'user.firstName as firstName',
        'user.lastName as lastName',
        'subOrder.note as note',
        'subOrder.rating as rating',
        'subOrder.repeatDriver as repeatDriver',
      ])
      .getRawMany<Rating>();
    return x;
  }
  async findForDriver(cars: Car[]): Promise<SubOrder[]> {
    const subOrders = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantages')
      .where('subOrder.status = :status', { status: SUB_ORDER_STATUS.READY })
      .andWhere('subOrder.carId is null')
      .select([
        'subOrder.id',
        'subOrder.cost',
        'subOrder.weight',
        'photos',
        'order.id',
        'order.locationStart',
        'order.locationEnd',
        'order.desiredDate',
        'order.porters',
        'advantages.name',
        'advantages.id',
      ])
      .orderBy('order.desiredDate', 'DESC')
      .getMany();
    const carAdvantagesIds = cars.flatMap((car) => car.advantages.map((adv) => adv.id));

    const carAdvantagesSet = new Set(carAdvantagesIds);
    return subOrders.filter((subOrder) => {
      const subOrderAdvantagesIds = subOrder.order.advantages.map((adv) => adv.id);
      return subOrderAdvantagesIds.every((id) => carAdvantagesSet.has(id));
    });
  }

  async findChats(personId: string, page: number, limit: number): Promise<PaginatedResponse<SubOrder>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.subOrderRepository.find({
      where: [
        {
          order: { userId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
        {
          car: { driverId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
      ],
      select: {
        order: {
          id: true,
          user: { id: true, firstName: true, lastName: true },
          locationEnd: { latitude: true, longitude: true, region: true, street: true },
          locationStart: { latitude: true, longitude: true, region: true, street: true },
        },
        car: {
          id: true,
          driver: { id: true, firstName: true, lastName: true },
        },
      },
      relations: { order: { user: true }, car: { driver: true } },
      skip,
      take,
    });

    const totalDataCount = await this.subOrderRepository.count({
      where: [
        {
          order: { userId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
        {
          car: { driverId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
      ],
      relations: { order: true, car: true },
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async findById(id: string): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantages')
      .leftJoinAndSelect('subOrder.car', 'car')
      .leftJoinAndSelect('car.driver', 'driver')
      .where('subOrder.id = :id', { id })
      .select([
        'subOrder',
        'photos',
        'order',
        'advantages.name',
        'advantages.id',
        'car.model',
        'car.brand',
        'car.color',
        'car.driverId',
        'driver.firstName',
        'driver.lastName',
      ])
      .getOne();
    return subOrder;
  }

  async findByIdWithAdvantages(id: string): Promise<SubOrder> {
    return this.subOrderRepository.findOne({
      where: { id },
      relations: ['order', 'order.advantages'],
    });
  }

  async findByIdForMessage(id: string, personId: string): Promise<SubOrder> {
    return await this.subOrderRepository.findOne({
      where: [
        {
          id,
          order: { userId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
        {
          id,
          car: { driverId: personId },
          status: In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.ON_THE_WAY, SUB_ORDER_STATUS.TAKEN]),
        },
      ],
      relations: { order: true, car: true },
    });
  }

  async create(orderId: string, dto: CreateSubOrderDto, cost: number, profit: number): Promise<SubOrder> {
    const sub = this.subOrderRepository.create({
      orderId,
      weight: dto.weight,
      cost: Math.round(cost - (cost * profit) / 100),
      realCost: cost,
    });
    return await this.subOrderRepository.save(sub);
  }

  async update(subOrder: SubOrder, dto: UpdateSubOrderDto): Promise<SubOrder> {
    subOrder.rating = dto.rating;
    subOrder.note = dto.note;
    subOrder.repeatDriver = dto.repeatDriver;
    return await this.subOrderRepository.save(subOrder);
  }

  async setArrivedAt(subOrder: SubOrder): Promise<SubOrder> {
    subOrder.arrivedAt = new Date();
    return await this.subOrderRepository.save(subOrder);
  }

  async setPickedUpAt(subOrder: SubOrder): Promise<SubOrder> {
    subOrder.pickedUpAt = new Date();
    subOrder.status = SUB_ORDER_STATUS.ON_THE_WAY;
    return await this.subOrderRepository.save(subOrder);
  }

  async setDeliveredAt(subOrder: SubOrder): Promise<SubOrder> {
    subOrder.deliveredAt = new Date();
    subOrder.status = SUB_ORDER_STATUS.DELIVERED;
    return await this.subOrderRepository.save(subOrder);
  }

  async setStatusToReady(orderId: string): Promise<any> {
    return await this.subOrderRepository.update(
      { orderId },
      { status: SUB_ORDER_STATUS.READY, acceptedAt: new Date() },
    );
  }

  async delete(id: string): Promise<void> {
    await this.subOrderRepository.softDelete({ id });
  }

  async refusedForOrder(orderId: string): Promise<void> {
    await this.subOrderRepository.update({ orderId }, { status: SUB_ORDER_STATUS.REFUSED });
  }

  async setDriver(subOrder: SubOrder, car: Car): Promise<SubOrder> {
    subOrder.carId = car.id;
    subOrder.car = car;
    subOrder.driverAssignedAt = new Date();
    subOrder.status = SUB_ORDER_STATUS.TAKEN;
    return await this.subOrderRepository.save(subOrder);
  }

  async areAllSubOrdersCompleted(orderId: string): Promise<boolean> {
    const incompleteSubOrderCount = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .where('subOrder.orderId = :orderId', { orderId })
      .andWhere('subOrder.status != :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .getCount();

    return incompleteSubOrderCount === 0;
  }

  async findTotalCost(id: string): Promise<number> {
    const result = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .select('SUM(subOrder.realCost)', 'totalCost')
      .where('subOrder.orderId = :id', { id })
      .getRawOne();
    return result.totalCost ?? 0;
  }

  async countSubOrdersCompletedForDriver(driverId: string): Promise<number> {
    const completeSubOrderCount = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.car', 'car')
      .where('car.driverId = :driverId', { driverId })
      .andWhere('subOrder.status = :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .getCount();

    return completeSubOrderCount;
  }

  async countSubOrdersCompleted(): Promise<number> {
    const count = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .where('subOrder.status = :status', {
        status: SUB_ORDER_STATUS.DELIVERED,
      })
      .getCount();
    return count;
  }

  async countSubOrdersActive(): Promise<number> {
    const count = await this.subOrderRepository.count({
      where: {
        status: Not(In([SUB_ORDER_STATUS.DELIVERED, SUB_ORDER_STATUS.REFUSED, SUB_ORDER_STATUS.WAITING])),
      },
    });
    return count;
  }

  async responseTime(): Promise<ResponseTime> {
    const queryResult = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .select(
        'AVG(CASE WHEN DATE(order.createdAt) = CURRENT_DATE THEN  subOrder.createdAt - order.createdAt  END)',
        'today',
      )
      .addSelect(
        'AVG(CASE WHEN DATE(order.createdAt) = CURRENT_DATE - 1 THEN subOrder.createdAt - order.createdAt  END)',
        'yesterday',
      )
      // .where('order.createdAt BETWEEN CURRENT_DATE AND CURRENT_DATE - 1 ')
      .getRawOne<ResponseTime>();

    return queryResult;
  }

  async staticProfits(startDate: string, endDate: string): Promise<StaticProfits[]> {
    const queryResult = await this.subOrderRepository
      .createQueryBuilder('subOrder')
      .select('DATE(subOrder.deliveredAt)', 'day')
      .addSelect('SUM(COALESCE(subOrder.realCost, 0) - COALESCE(subOrder.cost, 0))', 'profits')
      .where('subOrder.status = :status', { status: SUB_ORDER_STATUS.DELIVERED })
      .andWhere('subOrder.deliveredAt BETWEEN :startDate AND :endDate', {
        startDate,
        endDate,
      })
      .groupBy('day')
      .getRawMany<StaticProfits>();

    return queryResult;
  }
}
