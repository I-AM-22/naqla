// Order.controller.ts

import { bad_req, data_not_found, denied_error } from '@common/constants';
import { Auth, GetUser, Id, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { LoggingInterceptor } from '@common/interceptors';
import { IPerson } from '@common/interfaces';
import { SubOrdersService } from '@models/sub-orders/services/sub-orders.service';
import { User } from '@models/users/entities/user.entity';
import {
  Body,
  Controller,
  Delete,
  Get,
  Inject,
  Param,
  ParseUUIDPipe,
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
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Order } from '../entities/order.entity';
import { IOrdersService } from '../interfaces/services/orders.service.interface';
import { ORDER_TYPES } from '../interfaces/type';

@ApiTags('Orders')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'orders', version: '1' })
export class OrderController {
  constructor(
    @Inject(ORDER_TYPES.service) private readonly ordersService: IOrdersService,
    private readonly subordersService: SubOrdersService,
  ) {}

  @Roles(ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get()
  async findAll(): Promise<Order[]> {
    return this.ordersService.find();
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('mine')
  async findMine(@GetUser('id') userId: string): Promise<Order[]> {
    return this.ordersService.findMyOrders(userId);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('accepted')
  async findMineforAccepted(@GetUser('id') userId: string): Promise<Order[]> {
    return this.ordersService.findMineforAccepted(userId);
  }

  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('waiting')
  async findAllWaiting(): Promise<Order[]> {
    return this.ordersService.findWaiting();
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE, ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Order })
  @Get(':id')
  async findOne(@Id() id: string, @GetUser() user: IPerson): Promise<Order> {
    const order = await this.ordersService.findOne(id, user);
    return order;
  }
  // @Roles(ROLE.EMPLOYEE)
  // @ApiOkResponse({ type: Order })
  // @Get(':id/divisionDone')
  // async divisionDone(@Id() id: string): Promise<Order> {
  //   const cost = await this.subordersService.findTotalCost(id);
  //   const order = await this.ordersService.divisionDone(id, cost);
  //   return order;
  // }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order })
  @Get(':id/acceptance')
  async acceptance(@Id() id: string): Promise<Order> {
    await this.subordersService.ready(id);
    const order = await this.ordersService.acceptance(id);
    return order;
  }
  @Roles(ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Get(':id/cancellation')
  async cancellation(@Id() id: string): Promise<Order> {
    const order = await this.ordersService.cancellation(id);
    return order;
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order })
  @Get(':id/refusal')
  async refusal(@Id() id: string): Promise<Order> {
    const order = await this.ordersService.refusal(id);
    await this.subordersService.deleteForOrder(id);
    return order;
  }

  @Roles(ROLE.USER)
  @ApiCreatedResponse({ type: Order })
  @Post()
  async create(
    @Body() createOrderDto: CreateOrderDto,
    @GetUser() user: User,
  ): Promise<Order> {
    return await this.ordersService.create(user, createOrderDto);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Patch(':id')
  async update(
    @Id() id: string,
    @GetUser() user: IPerson,
    @Body() dto: UpdateOrderDto,
  ): Promise<Order> {
    return await this.ordersService.update(id, user, dto);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Id() id: string, @GetUser() user: IPerson): Promise<void> {
    await this.ordersService.delete(id, user);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse()
  @Post(':id/advantages')
  async addAdvantagesToOrder(
    @Id() id: string,
    @Body() createAdvantageDto: AddAdvansToOrderDto,
    @GetUser() user: User,
  ) {
    return this.ordersService.addAdvantagesToOrder(
      id,
      createAdvantageDto,
      user,
    );
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse()
  @Delete(':id/advantages/:advantageId')
  async removeAdvantagesFromOrder(
    @Id() id: string,
    @Param('advantageId', ParseUUIDPipe) advantageId: string,
    @GetUser() user: User,
  ) {
    return this.ordersService.removeAdvantagesFromOrder(id, advantageId, user);
  }
}
