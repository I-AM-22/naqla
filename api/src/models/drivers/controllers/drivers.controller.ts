import {
  UseInterceptors,
  Controller,
  SerializeOptions,
  Get,
  Patch,
  Body,
  HttpCode,
  HttpStatus,
  Delete,
  Query,
  Req,
  Inject,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOkResponse,
  ApiQuery,
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
} from '@nestjs/swagger';

import { UpdateDriverDto } from '../dtos';
import { Driver } from '../entities/driver.entity';
import { GetUser, Roles, CheckAbilities, Id } from '@common/decorators';
import { GROUPS, ROLE, Entities, Action } from '@common/enums';
import {
  LoggingInterceptor,
  WithDeletedInterceptor,
} from '@common/interceptors';
import { PaginatedResponse } from '@common/types';
import { ICrud } from '@common/interfaces';
import { bad_req, data_not_found, denied_error } from '@common/constants';
import { Request } from 'express';
import { IDriversService } from '../interfaces/services/drivers.service.interface';
import { DRIVER_TYPES } from '../interfaces/type';

@ApiTags('Drivers')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'drivers', version: '1' })
export class DriversController implements ICrud<Driver> {
  constructor(
    @Inject(DRIVER_TYPES.service) private driversService: IDriversService,
  ) {}

  @UseInterceptors(WithDeletedInterceptor)
  @SerializeOptions({ groups: [GROUPS.ALL_DRIVERS] })
  @ApiOkResponse({ type: PaginatedResponse<Driver> })
  @ApiQuery({
    name: 'page',
    allowEmptyValue: false,
    example: 1,
    required: false,
  })
  @ApiQuery({
    name: 'limit',
    allowEmptyValue: false,
    example: 10,
    required: false,
  })
  @Get()
  async find(
    @Query('page') page: number,
    @Query('limit') limit: number,
    @Req() req: Request & { query: { withDeleted: string } },
  ) {
    const withDeleted = JSON.parse(req.query.withDeleted);
    return this.driversService.find(page, limit, withDeleted);
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Roles(ROLE.DRIVER)
  @Get('myPhotos')
  async getMyPhotos(@GetUser() driver: Driver) {
    return this.driversService.getMyPhotos(driver);
  }
  create(...n: any[]): Promise<Driver> {
    return;
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Roles(ROLE.DRIVER)
  @Get('me')
  async getMe(@GetUser() driver: Driver) {
    return driver;
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Roles(ROLE.DRIVER)
  @Patch('me')
  async updateMe(@Body() dto: UpdateDriverDto, @GetUser() driver: Driver) {
    return this.driversService.updateMe(driver, dto);
  }

  @HttpCode(HttpStatus.NO_CONTENT)
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Roles(ROLE.DRIVER)
  @Delete('me')
  async deleteMe(@GetUser() driver: Driver) {
    return this.driversService.deleteMe(driver);
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Get(':id')
  async findOne(@Id() id: string) {
    return this.driversService.findOne(id);
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @CheckAbilities({ action: Action.Update, subject: Entities.Driver })
  @Patch(':id')
  async update(@Id() id: string, @Body() dto: UpdateDriverDto) {
    return this.driversService.update(id, dto);
  }

  @ApiNoContentResponse()
  @CheckAbilities({ action: Action.Delete, subject: Entities.Driver })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  async remove(@Id() id: string) {
    return this.driversService.remove(id);
  }

  // @ApiOperation({ summary: 'recover deleted driver' })
  // @CheckAbilities({ action: Action.Update, subject: Entities.Driver })
  // @SerializeOptions({ groups: [GROUPS.DRIVER] })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // async recover(@Id() id: string) {
  //   return this.driversService.recover(id);
  // }
}
