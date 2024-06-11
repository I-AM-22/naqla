import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  // Param,
  Delete,
  Inject,
  UseInterceptors,
} from '@nestjs/common';
import { CreateSubOrdersDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import {
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { Auth, GetUser, Id, Roles } from '@common/decorators';
import { SubOrder } from '../entities/sub-order.entity';
import { ROLE } from '@common/enums';
import { LoggingInterceptor } from '@common/interceptors';
import { bad_req, data_not_found, denied_error } from '@common/constants';
import { CarsService } from '@models/drivers/services/cars.service';
import { OrdersService } from '@models/orders/services/orders.service';
import { Order } from '@models/orders/entities/order.entity';

@ApiTags('SubOrders')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'sub-orders', version: '1' })
export class SubOrdersController {
  constructor(
    private readonly carService: CarsService,
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
    private readonly ordersService: OrdersService,
  ) {}
  @Roles(ROLE.EMPLOYEE, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Order })
  @Post()
  async create(@Body() CreateSubOrdersDto: CreateSubOrdersDto) {
    await this.subOrdersService.create(CreateSubOrdersDto);
    const cost = await this.subOrdersService.findTotalCost(
      CreateSubOrdersDto.orderId,
    );
    return await this.ordersService.divisionDone(
      CreateSubOrdersDto.orderId,
      cost,
    );
  }

  // @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder, isArray: true })
  @Get()
  async findAll(): Promise<SubOrder[]> {
    return this.subOrdersService.find();
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder, isArray: true })
  @Get('for-driver')
  async findAllForDriver(@GetUser('id') driverId: string): Promise<SubOrder[]> {
    const cars = await this.carService.findMyCars(driverId);
    return this.subOrdersService.findForDriver(cars);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: SubOrder })
  @Get(':id')
  async findOne(@Id() id: string): Promise<SubOrder> {
    const suborder = await this.subOrdersService.findOne(id);
    return suborder;
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: SubOrder })
  @Patch(':id')
  async update(
    @Id() id: string,
    @Body() dto: UpdateSubOrderDto,
  ): Promise<SubOrder> {
    return await this.subOrdersService.update(id, dto);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: SubOrder })
  @Patch(':id/setArrivedAt')
  async setArrivedAt(@Id() id: string): Promise<SubOrder> {
    return await this.subOrdersService.setArrivedAt(id);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: SubOrder })
  @Patch(':id/setPickedUpAt')
  async setPickedUpAt(@Id() id: string): Promise<SubOrder> {
    return await this.subOrdersService.setPickedUpAt(id);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder })
  @Patch(':id/setDeliveredAt')
  async setDeliveredAt(@Id() id: string): Promise<SubOrder> {
    return await this.subOrdersService.setDeliveredAt(id);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder })
  @Patch(':id/setDriver')
  async setDriver(
    @Id() id: string,
    @Body() dto: UpdateSubOrderDto,
  ): Promise<SubOrder> {
    return await this.subOrdersService.setDriver(id, dto.car);
  }

  @Roles(ROLE.EMPLOYEE)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Id() id: string): Promise<void> {
    await this.subOrdersService.delete(id);
  }
}
