import { bad_req, data_not_found, denied_error } from '@common/constants';
import { Auth, Id, Roles } from '@common/decorators';
import { LoggingInterceptor } from '@common/interceptors';
import { Controller, Get, Inject, UseInterceptors } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import { ROLE } from '@common/enums';
import { SubOrder } from '../entities/sub-order.entity';
import { OrderSubOrder } from '../responses/order-suborders.response';

@ApiTags('SubOrders')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'orders/:id', version: '1' })
export class OrdersSubOrdersController {
  constructor(
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
  ) {}

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: OrderSubOrder })
  @Get('sub-orders')
  async findForOrder(@Id() id: string): Promise<SubOrder[]> {
    const suborder = await this.subOrdersService.findForOrder(id);
    return suborder;
  }
}
