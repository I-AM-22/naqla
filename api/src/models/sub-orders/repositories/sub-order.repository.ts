import { SUB_ORDER_STATUS } from '@common/enums';
import { Car } from '@models/cars/entities/car.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { SubOrder } from '../entities/sub-order.entity';
import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';

@Injectable()
export class SubOrderRepository implements ISubOrderRepository {
  constructor(
    @InjectRepository(SubOrder)
    private readonly subOrderRepository: Repository<SubOrder>,
  ) {}

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
        'car.model',
        'car.brand',
        'car.color',
        'driver.firstName',
        'driver.lastName',
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
      .getMany();
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
      .getMany();

    const carAdvantagesIds = cars.flatMap((car) =>
      car.advantages.map((adv) => adv.id),
    );

    const carAdvantagesSet = new Set(carAdvantagesIds);
    return subOrders.filter((subOrder) => {
      const subOrderAdvantagesIds = subOrder.order.advantages.map(
        (adv) => adv.id,
      );
      return subOrderAdvantagesIds.every((id) => carAdvantagesSet.has(id));
    });
  }

  async findOne(id: string): Promise<SubOrder> {
    const subOrders = await this.subOrderRepository
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
        'driver.firstName',
        'driver.lastName',
      ])
      .getMany();
    return subOrders[0];
  }

  async findOneWithAdvantages(id: string): Promise<SubOrder> {
    return this.subOrderRepository.findOne({
      where: { id },
      relations: ['order', 'order.advantages'],
    });
  }

  async create(
    orderId: string,
    dto: CreateSubOrderDto,
    cost: number,
  ): Promise<SubOrder> {
    const sub = this.subOrderRepository.create({
      orderId,
      weight: dto.weight,
      cost,
    });
    return await this.subOrderRepository.save(sub);
  }

  async update(subOrder: SubOrder, dto: UpdateSubOrderDto): Promise<SubOrder> {
    subOrder.rating = dto.rating;
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

  async delete(subOrder: SubOrder): Promise<void> {
    await this.subOrderRepository.softRemove(subOrder);
  }

  async deleteForOrder(orderId: string): Promise<void> {
    await this.subOrderRepository.softRemove({ orderId });
  }

  async refusedForOrder(orderId: string): Promise<void> {
    await this.subOrderRepository.update(
      { orderId },
      { status: SUB_ORDER_STATUS.REFUSED },
    );
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
      .select('SUM(subOrder.cost)', 'totalCost')
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
}
