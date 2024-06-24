import { Controller, Get, Param } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Auth, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { bad_req, data_not_found, denied_error } from '@common/constants';
import { Numerical } from '../class/Numerical';
import { UserRepository } from '@models/users/repositories/user.repository';
import { DriverRepository } from '@models/drivers/repositories/driver/driver.repository';
import { CarRepository } from '@models/cars/repositories/car.repository';
import { OrderRepository } from '@models/orders/repositories/order.repository';
import { SubOrderRepository } from '@models/sub-orders/repositories/sub-order.repository';
import { OrderStatsDate } from '../class/OrderStatsDate';
import { AdvantageSuper } from '../class/AdvantageSuper';
import { StaticProfits } from '../class/StaticProfits';
import { ResponseTime } from '../class/ResponseTime';

@ApiTags('Statistics')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@Auth()
@Controller({ path: 'statistics', version: '1' })
export class CitiesController {
  constructor(
    private userRepository: UserRepository,
    private driverRepository: DriverRepository,
    private carRepository: CarRepository,
    private orderRepository: OrderRepository,
    private subOrderRepository: SubOrderRepository,
  ) {}
  @Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Numerical })
  @Get()
  async find() {
    const data = new Numerical();
    data.car = await this.carRepository.countCar();
    data.driver = await this.driverRepository.countDriver();
    data.user = await this.userRepository.countUser();
    data.orderCompleted = await this.orderRepository.countOrdersCompleted();
    data.orderActive = await this.orderRepository.countOrdersActive();
    data.orderWaiting = await this.orderRepository.countOrdersWaiting();
    data.subOrderActive =
      await this.subOrderRepository.countSubOrdersCompleted();
    data.subOrderCompleted =
      await this.subOrderRepository.countSubOrdersActive();
    return data;
  }

  @Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: ResponseTime })
  @Get('/responseTime')
  async responseTime() {
    return await this.subOrderRepository.responseTime();
  }

  @Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: OrderStatsDate })
  @Get('order/:first_date/:second_date')
  findForDate(
    @Param('first_date') first: string,
    @Param('second_date') second: string,
  ) {
    return this.orderRepository.StaticsOrdersForDate(first, second);
  }

  @Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: StaticProfits })
  @Get('profits/:first_date/:second_date')
  profits(
    @Param('first_date') first: string,
    @Param('second_date') second: string,
  ) {
    return this.orderRepository.staticProfits(first, second);
  }

  @Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: AdvantageSuper })
  @Get('advantages/:limit')
  async findLimetAdvantages(@Param('limit') limit: number) {
    const ad = await this.orderRepository.advantageSuper(limit);
    const data: AdvantageSuper[] = [];
    for (let i = 0; i < ad.length && i < limit; i++) {
      const obj = new AdvantageSuper();
      obj.advantage = ad[i].advantage;
      obj.countUserUsed = +ad[i].x;
      obj.countCarUsed = await this.carRepository.countCarAdvantage(
        ad[i].advantage,
      );
      data.push(obj);
    }
    return data;
  }
}
