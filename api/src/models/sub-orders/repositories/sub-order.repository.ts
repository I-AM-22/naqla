import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
// import { Order } from '../entities/order.entity';
// import { OrderPhoto } from '../../orders/entities/order-photo.entity';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
// import { Advantage } from '../../advantages/entities/advantage.entity';
// import { User } from '../../users';
// import { SUB_ORDER_STATUS } from '../../../common/enums';
import { SubOrder } from '../entities/sub-order.entity';
import { SUB_ORDER_STATUS } from '../../../common/enums';
import { Car } from '../../drivers/entities/car.entity';

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
    let supOrderToDriver: SubOrder[];
    const subReady = await this.suporderRepository.find({
      where: { status: SUB_ORDER_STATUS.READY, carId: null },
      relations: { order: true },
    });
    for (let i = 0; i < subReady.length; i++) {
      cars.forEach((item) => {
        if (item.advantages == subReady[i].order.advantages) {
          supOrderToDriver.push(subReady[i]);
          return;
        }
      });
    }
    return supOrderToDriver;
  }

  async findOne(id: string): Promise<SubOrder> {
    return this.suporderRepository.findOne({
      where: { id },
    });
  }

  async create(dto: CreateSubOrderDto, cost: number): Promise<SubOrder> {
    const sub = this.suporderRepository.create({
      orderId: dto.orderId,
      weight: dto.weight,
      cost,
      // cost: Math.floor(Math.random() * 1000),
    });
    return await this.suporderRepository.save(sub);
  }

  async update(id: string, dto: UpdateSubOrderDto): Promise<SubOrder> {
    const doc = await this.suporderRepository.findOne({ where: { id } });
    doc.rating = dto.rating;
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
}
