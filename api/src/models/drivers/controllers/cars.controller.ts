// car.controller.ts

import {
  Controller,
  Post,
  Body,
  Inject,
  UseGuards,
  UseInterceptors,
  ParseUUIDPipe,
} from '@nestjs/common';
import { CreateCarDto, UpdateCarDto } from '../dtos';
import { Param, Get, Patch, Delete } from '@nestjs/common';
import { Car } from '../entities/car.entity';
import { ICarsService } from '../interfaces/services/cars.service.interface';
import { CAR_TYPES } from '../interfaces/type';
import { GetUser, Roles } from '../../../common/decorators';
import { Driver } from '../entities/driver.entity';
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

@ApiTags('cars')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseInterceptors(new LoggingInterceptor())
@UseGuards(CaslAbilitiesGuard, RolesGuard)
@Controller({ path: 'drivers/cars', version: '1' })
export class CarController {
  constructor(
    @Inject(CAR_TYPES.service) private readonly carsService: ICarsService,
  ) {}

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car, isArray: true })
  @Get('mine')
  async findMine(@GetUser('id') driverId: string): Promise<Car[]> {
    return this.carsService.findMyCars(driverId);
  }

  @Roles(ROLE.ADMIN, ROLE.SUPER_ADMIN)
  @ApiOkResponse({ type: Car, isArray: true })
  @Get('all')
  async findAll(): Promise<Car[]> {
    return this.carsService.find();
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car })
  @Get(':id')
  async findOne(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') driverId: string,
  ): Promise<Car> {
    const car = await this.carsService.findOneForOwner(id, driverId);

    return car;
  }

  @Roles(ROLE.DRIVER)
  @ApiCreatedResponse({ type: Car })
  @Post()
  async create(
    @Body() createCarDto: CreateCarDto,
    @GetUser() driver: Driver,
  ): Promise<Car> {
    return await this.carsService.create(driver, createCarDto);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car })
  @Patch(':id')
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') driverId: string,
    @Body() dto: UpdateCarDto,
  ): Promise<Car> {
    return await this.carsService.update(id, driverId, dto);
  }

  @Roles(ROLE.DRIVER)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(
    @Param('id', ParseUUIDPipe) id: string,
    @GetUser('id') driverId: string,
  ): Promise<void> {
    await this.carsService.delete(id, driverId);
  }
}
