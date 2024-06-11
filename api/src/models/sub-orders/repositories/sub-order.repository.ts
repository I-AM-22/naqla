import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { sub } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { SubOrder } from '../entities/sub-order.entity';
import { SUB_ORDER_STATUS } from '@common/enums';
import { Car } from '@models/drivers/entities/car.entity';

@Injectable()
export class SubOrderRepository implements ISubOrderRepository {
  constructor(
    @InjectRepository(SubOrder)
    private readonly suporderRepository: Repository<SubOrder>,
  ) {}

  async find(): Promise<SubOrder[]> {
    return this.suporderRepository.find();
  }

  async findWaiting(): Promise<SubOrder[]> {
    return this.suporderRepository.find();
  }

  async findForOrder(orderId: string): Promise<SubOrder[]> {
    return this.suporderRepository.find({
      where: { orderId },
    });
  }

  async findForDriver(cars: Car[]): Promise<SubOrder[]> {
    const subOrderQuery = this.suporderRepository
      .createQueryBuilder('subOrder')
      .leftJoinAndSelect('subOrder.order', 'order')
      .leftJoinAndSelect('subOrder.photos', 'photos')
      .leftJoinAndSelect('order.advantages', 'advantage')
      .where('subOrder.status = :status', { status: SUB_ORDER_STATUS.READY })
      .andWhere('subOrder.carId is null')
      .select([
        'subOrder.id',
        'subOrder.cost',
        'subOrder.weight',
        'photos',
        'order.locationStart',
        'order.locationEnd',
        'order.desiredDate',
        'order.porters',
        'advantage.name',
      ]);

    const carAdvantagesIds = cars.flatMap((car) =>
      car.advantages.map((adv) => adv.id),
    );

    if (carAdvantagesIds.length > 0) {
      subOrderQuery.andWhere('advantage.id IN (:...carAdvantagesIds)', {
        carAdvantagesIds,
      });
    }
    return await subOrderQuery.getMany();
  }

  async findOne(id: string): Promise<SubOrder> {
    return this.suporderRepository.findOne({
      where: { id },
    });
  }

  async create(id: string, dto: sub, cost: number): Promise<SubOrder> {
    const sub = this.suporderRepository.create({
      orderId: id,
      weight: dto.weight,
      cost,
    });
    return await this.suporderRepository.save(sub);
  }

  async update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.rating = dto.rating;
    return await this.suporderRepository.save(doc);
  }
  async setArrivedAt(id: string): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.arrivedAt = new Date().toISOString();
    return await this.suporderRepository.save(doc);
  }

  async setPickedUpAt(id: string): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.pickedUpAt = new Date().toISOString();
    doc.status = SUB_ORDER_STATUS.ON_THE_WAY;
    return await this.suporderRepository.save(doc);
  }
  async setDeliveredAt(id: string): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.deliveredAt = new Date().toISOString();
    doc.status = SUB_ORDER_STATUS.DELIVERED;
    return await this.suporderRepository.save(doc);
  }

  async ready(id: string): Promise<any> {
    return await this.suporderRepository.update(
      { orderId: id },
      { status: SUB_ORDER_STATUS.READY, acceptedAt: new Date().toISOString() },
    );
  }

  async delete(id: string): Promise<void> {
    await this.suporderRepository.delete(id);
  }

  async deleteForOrder(id: string): Promise<void> {
    await this.suporderRepository.delete({ orderId: id });
  }

  async setDriver(id: string, car: Car): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.carId = car.id;
    doc.car = car;
    doc.driverAssignedAt = new Date().toISOString();
    doc.status = SUB_ORDER_STATUS.TAKEN;
    return await this.suporderRepository.save(doc);
  }

  async findTotalCost(id: string): Promise<number> {
    const result = await this.suporderRepository
      .createQueryBuilder('suporder')
      .select('SUM(suporder.cost)', 'totalCost')
      .where('suporder.orderId = :id', { id })
      .getRawOne();
    return result.totalCost ?? 0;
  }
}
