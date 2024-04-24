import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Inject,
} from '@nestjs/common';
import { CreateSubOrderDto } from '../dto/create-sub-order.dto';
import { UpdateSubOrderDto } from '../dto/update-sub-order.dto';
import { ISubOrdersService } from '../interfaces/services/sub-orders.service.interface';
import { SUB_ORDER_TYPES } from '../interfaces/type';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('SubOrders')
@Controller('sub-orders')
export class SubOrdersController {
  constructor(
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
  ) {}

  @Post()
  create(@Body() createSubOrderDto: CreateSubOrderDto) {}

  @Get()
  findAll() {}

  @Get(':id')
  findOne(@Param('id') id: string) {}

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateSubOrderDto: UpdateSubOrderDto,
  ) {}

  @Delete(':id')
  remove(@Param('id') id: string) {}
}
