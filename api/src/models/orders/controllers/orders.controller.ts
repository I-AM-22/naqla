// Order.controller.ts

import {
  Controller,
  Post,
  Body,
  Inject,
  UseInterceptors,
  ParseUUIDPipe,
} from '@nestjs/common';
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Param, Get, Patch, Delete } from '@nestjs/common';
import { Order } from '../entities/order.entity';
import { IOrdersService } from '../interfaces/services/ordrs.service.interface';
import { ORDER_TYPES } from '../interfaces/type';
import { Auth, GetUser, Id, Roles } from '../../../common/decorators';
import { User } from '../../users/entities/user.entity';
import {
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiTags,
} from '@nestjs/swagger';
import {
  bad_req,
  denied_error,
  data_not_found,
} from '../../../common/constants';
import { LoggingInterceptor } from '../../../common/interceptors';
import { ROLE } from '../../../common/enums';
import { IPerson } from '../../../common/interfaces';

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

  @Roles(ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('waiting')
  async findAllWaiting(): Promise<Order[]> {
    return this.ordersService.findWaiting();
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Get(':id')
  async findOne(@Id() id: string, @GetUser() user: IPerson): Promise<Order> {
    const order = await this.ordersService.findOne(id, user);
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
