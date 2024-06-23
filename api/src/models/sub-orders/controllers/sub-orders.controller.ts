import { bad_req, data_not_found, denied_error } from '@common/constants';
import { Auth, GetUser, Id, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { LoggingInterceptor } from '@common/interceptors';
import { Order } from '@models/orders/entities/order.entity';
import {
  Body,
  Controller,
  // Param,
  Delete,
  Get,
  Inject,
  Patch,
  Post,
  UseInterceptors,
} from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { CreateSubOrdersDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { SubOrder } from '../entities/sub-order.entity';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import { SetDriverSubOrderDto } from '../dto/set-driver.dto';

@ApiTags('SubOrders')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'sub-orders', version: '1' })
export class SubOrdersController {
  constructor(
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
  ) {}

  @Roles(ROLE.EMPLOYEE, ROLE.SUPER_ADMIN)
  @ApiCreatedResponse({ type: Order })
  @Post()
  async create(@Body() dto: CreateSubOrdersDto) {
    return await this.subOrdersService.create(dto);
  }

  @ApiOkResponse({ type: SubOrder, isArray: true })
  @Get()
  async findAll(): Promise<SubOrder[]> {
    return this.subOrdersService.find();
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder, isArray: true })
  @Get('for-driver')
  async findAllForDriver(@GetUser('id') driverId: string): Promise<SubOrder[]> {
    return this.subOrdersService.findForDriver(driverId);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: SubOrder, isArray: true })
  @Get('active-driver')
  async findAllActiveForDriver(
    @GetUser('id') driverId: string,
  ): Promise<SubOrder[]> {
    return this.subOrdersService.findAllActiveForDriver(driverId);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ isArray: true, type: SubOrder })
  @Get('done-driver')
  async findIsDoneForDriver(
    @GetUser('id') driverId: string,
  ): Promise<SubOrder[]> {
    return await this.subOrdersService.findIsDoneForDriver(driverId);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: SubOrder })
  @Get('order/:id')
  async findForOrder(@Id() id: string): Promise<SubOrder[]> {
    const suborder = await this.subOrdersService.findForOrder(id);
    return suborder;
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE, ROLE.DRIVER)
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
    @Body() dto: SetDriverSubOrderDto,
  ): Promise<SubOrder> {
    return await this.subOrdersService.setDriver(id, dto.carId);
  }

  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Id() id: string): Promise<void> {
    await this.subOrdersService.delete(id);
  }
}
