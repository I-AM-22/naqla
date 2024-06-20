import { SUB_ORDER_STATUS } from '@common/enums';
import { Car } from '@models/drivers/entities/car.entity';
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
      .select([
        'subOrder.id',
        'subOrder.cost',
        'subOrder.status',
        'subOrder.weight',
        'photos',
        'order.locationStart',
        'order.locationEnd',
        'order.desiredDate',
        'order.porters',
        'advantages.name',
      ])
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
      .select([
        'subOrder.id',
        'subOrder.cost',
        'subOrder.rating',
        'subOrder.weight',
        'subOrder.deliveredAt',
        'photos',
        'order.locationStart',
        'order.locationEnd',
        'order.desiredDate',
        'order.porters',
        'advantages.name',
      ])
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
        'car.model',
        'car.brand',
        'car.color',
        'driver.firstName',
        'driver.lastName',
      ])
      .getMany();
    return subOrders[0];
  }

  async create(
    id: string,
    dto: CreateSubOrderDto,
    cost: number,
  ): Promise<SubOrder> {
    const sub = this.subOrderRepository.create({
      orderId: id,
      weight: dto.weight,
      cost,
    });
    return await this.subOrderRepository.save(sub);
  }

  async update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder> {
    const doc = await this.subOrderRepository.findOne({ where: { id } });
    doc.rating = dto.rating;
    return await this.subOrderRepository.save(doc);
  }
  async setArrivedAt(id: string): Promise<SubOrder> {
    const doc = await this.subOrderRepository.findOne({ where: { id } });
    doc.arrivedAt = new Date().toISOString();
    return await this.subOrderRepository.save(doc);
  }

  async setPickedUpAt(id: string): Promise<SubOrder> {
    const doc = await this.subOrderRepository.findOne({ where: { id } });
    doc.pickedUpAt = new Date().toISOString();
    doc.status = SUB_ORDER_STATUS.ON_THE_WAY;
    return await this.subOrderRepository.save(doc);
  }
  async setDeliveredAt(id: string): Promise<SubOrder> {
    const doc = await this.subOrderRepository.findOne({
      where: { id },
      relations: { car: true, order: true },
    });
    doc.deliveredAt = new Date().toISOString();
    doc.status = SUB_ORDER_STATUS.DELIVERED;
    return await this.subOrderRepository.save(doc);
  }

  async ready(id: string): Promise<any> {
    return await this.subOrderRepository.update(
      { orderId: id },
      { status: SUB_ORDER_STATUS.READY, acceptedAt: new Date().toISOString() },
    );
  }

  async delete(id: string): Promise<void> {
    await this.subOrderRepository.delete(id);
  }

  async deleteForOrder(id: string): Promise<void> {
    await this.subOrderRepository.delete({ orderId: id });
  }

  async refusedForOrder(id: string): Promise<boolean> {
    const result = await this.subOrderRepository
      .createQueryBuilder()
      .update(SubOrder)
      .set({ status: SUB_ORDER_STATUS.REFUSED })
      .where('orderId = :id', { id })
      .returning('*')
      .execute();
    if (!result) {
      throw new Error('order not found');
    }
    return true;
  }

  async setDriver(id: string, car: Car): Promise<SubOrder> {
    const subOrder = await this.subOrderRepository.findOne({
      where: { id },
      relations: ['order', 'order.advantages'],
    });

    if (!subOrder) {
      throw new Error(`SubOrder with id ${id} not found`);
    }

    const requestedFeatures = subOrder.order.advantages.map(
      (feature) => feature.id,
    );

    const carFeatures = car.advantages.map((advantage) => advantage.id);
    const hasAllFeatures = requestedFeatures.every((feature) =>
      carFeatures.includes(feature),
    );

    if (!hasAllFeatures) {
      throw new Error(`Car does not have all the requested features`);
    }
    subOrder.carId = car.id;
    subOrder.car = car;
    subOrder.driverAssignedAt = new Date().toISOString();
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

  async countSubOrdersCompletedFordriver(driverId: string): Promise<number> {
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
