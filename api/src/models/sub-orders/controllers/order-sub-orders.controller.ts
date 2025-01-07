import { ApiMainErrorsResponse, Auth, Id, Roles } from '@common/decorators';
import { LoggingInterceptor } from '@common/interceptors';
import { Controller, Get, UseInterceptors } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ROLE } from '@common/enums';
import { SubOrder } from '../entities/sub-order.entity';
import { OrderSubOrder } from '../responses/order-suborders.response';
import { SubOrdersService } from '../services/sub-orders.service';

@ApiTags('SubOrders')
@ApiMainErrorsResponse()
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'orders/:id', version: '1' })
export class OrdersSubOrdersController {
  constructor(private readonly subOrdersService: SubOrdersService) {}

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: OrderSubOrder })
  @Get('sub-orders')
  async findForOrder(@Id() id: string): Promise<SubOrder[]> {
    const suborder = await this.subOrdersService.findForOrder(id);
    return suborder;
  }
}
