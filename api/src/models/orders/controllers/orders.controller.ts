// Order.controller.ts

import {
  Controller,
  Post,
  Body,
  Inject,
  UseGuards,
  UseInterceptors,
  ParseUUIDPipe,
  // SerializeOptions,
} from '@nestjs/common';
import { AddAdvansToOrderDto, CreateOrderDto, UpdateOrderDto } from '../dtos';
import { Param, Get, Patch, Delete } from '@nestjs/common';
import { Order } from '../entities/order.entity';
import { IOrdersService } from '../interfaces/services/ordrs.service.interface';
import { ORDER_TYPES } from '../interfaces/type';
import { GetUser, Roles } from '../../../common/decorators';
import { User } from '../../users/entities/user.entity';
import {
  ApiBearerAuth,
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
import { CaslAbilitiesGuard, RolesGuard } from '../../../common/guards';
import { LoggingInterceptor } from '../../../common/interceptors';
import { ROLE } from '../../../common/enums';

@ApiTags('Orders')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseInterceptors(new LoggingInterceptor())
@UseGuards(CaslAbilitiesGuard, RolesGuard)
@Controller({ path: 'drivers/Orders', version: '1' })
export class OrderController {
  constructor(
    @Inject(ORDER_TYPES.service) private readonly OrdersService: IOrdersService,
  ) {}

  // @SerializeOptions({ groups: [GROUPS.ALL_OrderS] })
  @Roles(ROLE.USER)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('mine')
  async findMine(@GetUser('id') userId: string): Promise<Order[]> {
    return this.OrdersService.findMyOrders(userId);
  }

  // @SerializeOptions({ groups: [GROUPS.Order] })
  @Roles(ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('all')
  async findAll(): Promise<Order[]> {
    return this.OrdersService.find();
  }

  @Roles(ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order, isArray: true })
  @Get('waiting')
  async findAllwaiting(): Promise<Order[]> {
    return this.OrdersService.findwaiting();
  }

  // @SerializeOptions({ groups: [GROUPS.Order] })
  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Get(':id')
  async findOne(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') userId: string,
  ): Promise<Order> {
    const order = await this.OrdersService.findOneForOwner(id, userId);
    return order;
  }

  // @SerializeOptions({ groups: [GROUPS.Order] })
  @Roles(ROLE.USER)
  @ApiCreatedResponse({ type: Order })
  @Post()
  async create(
    @Body() createOrderDto: CreateOrderDto,
    @GetUser() user: User,
  ): Promise<Order> {
    return await this.OrdersService.create(user, createOrderDto);
  }

  // @SerializeOptions({ groups: [GROUPS.Order] })
  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Order })
  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') userId: string,
    @Body() dto: UpdateOrderDto,
  ): Promise<Order> {
    return await this.OrdersService.update(id, userId, dto);
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') driverId: string,
  ): Promise<void> {
    await this.OrdersService.delete(id, driverId);
  }

  @Roles(ROLE.USER)
  @ApiOkResponse()
  @Post(':id/advantages')
  async addAdvantagesToOrder(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() createAdvantageDto: AddAdvansToOrderDto,
    @GetUser() user: User,
  ) {
    return this.OrdersService.addAdvantagesToOrder(
      id,
      createAdvantageDto,
      user,
    );
  }

  @Roles(ROLE.USER, ROLE.EMPLOYEE)
  @ApiOkResponse()
  @Delete(':id/advantages/:advantageId')
  async removeAdvantagesFromOrder(
    @Param('id', ParseUUIDPipe) id: string,
    @Param('advantageId', ParseUUIDPipe) advantageId: string,
    @GetUser() user: User,
  ) {
    return this.OrdersService.removeAdvantagesFromOrder(id, advantageId, user);
  }
}
