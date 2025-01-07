import {
  Controller,
  Post,
  Body,
  UseInterceptors,
  ParseUUIDPipe,
  SerializeOptions,
  Delete,
  Get,
  Param,
  Patch,
} from '@nestjs/common';

import { ApiOkResponse, ApiCreatedResponse, ApiNoContentResponse, ApiTags } from '@nestjs/swagger';
import { LoggingInterceptor } from '@common/interceptors';
import { GROUPS, ROLE } from '@common/enums';
import { ApiMainErrorsResponse, Auth, GetUser, Id, Roles } from '@common/decorators';
import { CreateCarDto, UpdateCarDto, AddAdvansToCarDto } from '../dtos';
import { Car } from '../entities/car.entity';
import { Driver } from '@models/drivers/entities/driver.entity';
import { CarsService } from '../services/cars.service';

@ApiTags('Cars')
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'cars', version: '1' })
export class CarController {
  constructor(private readonly carsService: CarsService) {}

  @SerializeOptions({ groups: [GROUPS.ALL_CARS] })
  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car, isArray: true })
  @Get('mine')
  async findMine(@GetUser('id') driverId: string): Promise<Car[]> {
    return this.carsService.findMyCars(driverId);
  }

  @SerializeOptions({ groups: [GROUPS.CAR] })
  @Roles(ROLE.ADMIN)
  @ApiOkResponse({ type: Car, isArray: true })
  @Get('all')
  async findAll(): Promise<Car[]> {
    return this.carsService.find();
  }

  @SerializeOptions({ groups: [GROUPS.CAR] })
  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car })
  @Get(':id')
  async findOne(@Id() id: string, @GetUser('id') driverId: string): Promise<Car> {
    const car = await this.carsService.findOneForOwner(id, driverId);

    return car;
  }

  @SerializeOptions({ groups: [GROUPS.CAR] })
  @Roles(ROLE.DRIVER)
  @ApiCreatedResponse({ type: Car })
  @Post()
  async create(@Body() createCarDto: CreateCarDto, @GetUser() driver: Driver): Promise<Car> {
    return await this.carsService.create(driver, createCarDto);
  }

  @SerializeOptions({ groups: [GROUPS.CAR] })
  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car })
  @Patch(':id')
  async update(@Id() id: string, @GetUser('id') driverId: string, @Body() dto: UpdateCarDto): Promise<Car> {
    return await this.carsService.update(id, driverId, dto);
  }

  @Roles(ROLE.DRIVER)
  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Id() id: string, @GetUser('id') driverId: string): Promise<void> {
    await this.carsService.delete(id, driverId);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse()
  @Post(':id/advantages')
  async addAdvantagesToCar(@Id() id: string, @Body() createAdvantageDto: AddAdvansToCarDto, @GetUser() driver: Driver) {
    return this.carsService.addAdvantagesToCar(id, createAdvantageDto, driver);
  }

  @Roles(ROLE.DRIVER)
  @ApiOkResponse()
  @Delete(':id/advantages/:advantageId')
  async removeAdvantagesFromCar(
    @Id() id: string,
    @Param('advantageId', ParseUUIDPipe) advantageId: string,
    @GetUser() driver: Driver,
  ) {
    return this.carsService.removeAdvantagesFromCar(id, advantageId, driver);
  }
}
