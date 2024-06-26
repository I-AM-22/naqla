import { IDriverRepository } from '@models/drivers/interfaces/repositories/driver.repository.interface';
import { DRIVER_TYPES } from '@models/drivers/interfaces/type';
import { IOrderRepository } from '@models/orders/interfaces/repositories/order.repository.interface';
import { ORDER_TYPES } from '@models/orders/interfaces/type';
import { ISubOrderRepository } from '@models/sub-orders/interfaces/repositories/sub-order.repository.interface';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { IUserRepository } from '@models/users/interfaces/repositories/user.repository.interface';
import { USER_TYPES } from '@models/users/interfaces/type';
import { Inject, Injectable } from '@nestjs/common';
import { Numerical } from '../responses/Numerical';
import { AdvantageSuper } from '../responses/AdvantageSuper';
import { CarRepository } from '@models/cars/repositories/car.repository';

@Injectable()
export class StatisticsService {
  constructor(
    @Inject(USER_TYPES.repository.user)
    private userRepository: IUserRepository,
    @Inject(DRIVER_TYPES.repository.driver)
    private driverRepository: IDriverRepository,
    // @Inject(CAR_TYPES.repository.car)
    private carRepository: CarRepository,
    @Inject(ORDER_TYPES.repository.order)
    private orderRepository: IOrderRepository,
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private subOrderRepository: ISubOrderRepository,
  ) {}
  async find() {
    const data = new Numerical();
    data.car = await this.carRepository.countCar();
    data.driver = await this.driverRepository.countDriver();
    data.user = await this.userRepository.countUser();
    data.orderCompleted = await this.orderRepository.countOrdersCompleted();
    data.orderActive = await this.orderRepository.countOrdersActive();
    data.orderWaiting = await this.orderRepository.countOrdersWaiting();
    data.subOrderActive = await this.subOrderRepository.countSubOrdersCompleted();
    data.subOrderCompleted = await this.subOrderRepository.countSubOrdersActive();
    return data;
  }

  async responseTime() {
    return await this.subOrderRepository.responseTime();
  }

  async staticsOrdersForDate(first: string, second: string) {
    return await this.orderRepository.staticsOrdersForDate(first, second);
  }

  async staticProfits(first: string, second: string) {
    return await this.orderRepository.staticProfits(first, second);
  }

  async findLimitAdvantages(limit: number) {
    const ad = await this.orderRepository.advantageSuper(limit);
    const data: AdvantageSuper[] = [];
    for (let i = 0; i < ad.length && i < limit; i++) {
      const obj = new AdvantageSuper();
      obj.advantage = ad[i].advantage;
      obj.countUserUsed = +ad[i].x;
      obj.countCarUsed = await this.carRepository.countCarAdvantage(ad[i].advantage);
      data.push(obj);
    }
    return data;
  }
}
