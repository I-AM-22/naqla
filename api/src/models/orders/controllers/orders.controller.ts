// Order.controller.ts

import { ApiMainErrorsResponse, Auth, GetUser, Id, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { LoggingInterceptor } from '@common/interceptors';
import { IPerson } from '@common/interfaces';
import { User } from '@models/users/entities/user.entity';
import { Body, Controller, Delete, Get, Param, ParseUUIDPipe, Patch, Post, UseInterceptors } from '@nestjs/common';
import { ApiCreatedResponse, ApiNoContentResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Order } from '../entities/order.entity';
import { OrdersService } from '../services/orders.service';

@ApiTags('Orders')
@ApiMainErrorsResponse()
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'orders', version: '1' })
export class OrderController {
  constructor(private readonly ordersService: OrdersService) {}

  @Roles(ROLE.USER)
  @ApiCreatedResponse({ type: Order })
  @Post()
  async create(@Body() createOrderDto: CreateOrderDto, @GetUser() user: User): Promise<Order> {
    return await this.ordersService.create(user, createOrderDto);
  }

  @Roles(ROLE.ADMIN)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get()
  async findAll(): Promise<Order[]> {
    return await this.ordersService.find();
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('mine')
  async findMine(@GetUser('id') userId: string): Promise<Order[]> {
    return await this.ordersService.findMyOrders(userId);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('accepted')
  async findMineForAccepted(@GetUser('id') userId: string) {
    return await this.ordersService.findMineWithAccepted(userId);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('active-user')
  async findAllActiveForDriver(@GetUser('id') userId: string) {
    return this.ordersService.findAllActiveForUser(userId);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('done-user')
  async findAllDoneForUser(@GetUser('id') userId: string) {
    return this.ordersService.findAllDoneForUser(userId);
  }

  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('waiting')
  async findAllWaiting(): Promise<Order[]> {
    return this.ordersService.findWaiting();
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE, ROLE.ADMIN)
  @ApiOkResponse({ type: Order })
  @Get(':id')
  async findOne(@Id() id: string, @GetUser() user: IPerson): Promise<Order> {
    const order = await this.ordersService.findOne(id, user);
    return order;
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order })
  @Patch(':id/acceptance')
  async acceptance(@Id() id: string): Promise<Order> {
    return await this.ordersService.acceptance(id);
  }
  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN)
  @ApiOkResponse({ type: Order })
  @Patch(':id/cancellation')
  async cancellation(@Id() id: string): Promise<Order> {
    return await this.ordersService.cancellation(id);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order })
  @Patch(':id/refusal')
  async refusal(@Id() id: string): Promise<Order> {
    return await this.ordersService.refusal(id);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Patch(':id')
  async update(@Id() id: string, @GetUser() user: IPerson, @Body() dto: UpdateOrderDto): Promise<Order> {
    return await this.ordersService.update(id, user, dto);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Id() id: string): Promise<void> {
    await this.ordersService.delete(id);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse()
  @Post(':id/advantages')
  async addAdvantagesToOrder(@Id() id: string, @Body() createAdvantageDto: AddAdvansToOrderDto, @GetUser() user: User) {
    return this.ordersService.addAdvantagesToOrder(id, createAdvantageDto, user);
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
