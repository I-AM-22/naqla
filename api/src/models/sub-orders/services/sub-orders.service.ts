import { Inject, Injectable } from '@nestjs/common';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { ISubOrderRepository } from '../interfaces/repositories/sub-order.repository.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';

@Injectable()
export class SubOrdersService {
  constructor(
    @Inject(SUB_ORDER_TYPES.repository)
    private readonly subOrderRepository: ISubOrderRepository,
  ) {}

  create(createSubOrderDto: CreateSubOrderDto) {
    return 'This action adds a new subOrder';
  }

  findAll() {
    return `This action returns all subOrders`;
  }

  findOne(id: string) {
    return `This action returns a #${id} subOrder`;
  }

  update(id: string, updateSubOrderDto: UpdateSubOrderDto) {
    return `This action updates a #${id} subOrder`;
  }

  remove(id: string) {
    return `This action removes a #${id} subOrder`;
  }
}
