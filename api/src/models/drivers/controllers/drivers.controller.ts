import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Patch,
  Query,
  Req,
  SerializeOptions,
  UseInterceptors,
} from '@nestjs/common';
import { ApiNoContentResponse, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, CheckAbilities, GetUser, Id, Roles } from '@common/decorators';
import { Action, Entities, GROUPS, ROLE } from '@common/enums';
import { LoggingInterceptor, WithDeletedInterceptor } from '@common/interceptors';
import { Request } from 'express';
import { UpdateDriverDto } from '../dtos';
import { UpdateWalletDto } from '../dtos/update-wallet.dto ';
import { DriverWallet } from '../entities/driver-wallet.entity';
import { Driver } from '../entities/driver.entity';
import { DriverWalletRepository } from '../repositories/driver/driver-wallet.repository';
import { PaginatedDriverResponse } from '../responses/pagination.response';
import { Rating } from '@models/sub-orders/interfaces/rating';
import { DriversService } from '../services/drivers.service';

@ApiTags('Drivers')
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'drivers', version: '1' })
export class DriversController {
  constructor(
    private driversService: DriversService,
    private walletRepository: DriverWalletRepository,
  ) {}

  @UseInterceptors(WithDeletedInterceptor)
  // @SerializeOptions({ groups: [GROUPS.ALL_DRIVERS] })
  @ApiOkResponse({ type: PaginatedDriverResponse })
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
    @Query('active') active: boolean,
    @Query('limit') limit: number,
    @Req() req: Request & { query: { withDeleted: string } },
  ) {
    const withDeleted = JSON.parse(req.query.withDeleted);
    return this.driversService.find(page, limit, active, withDeleted);
  }

  @ApiOkResponse({ type: Driver })
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Roles(ROLE.DRIVER)
  @Get('myPhotos')
  async getMyPhotos(@GetUser() driver: Driver) {
    return this.driversService.getMyPhotos(driver);
  }

  @ApiOkResponse({ type: Driver })
  @Roles(ROLE.DRIVER)
  @Get('me')
  async getMe(@GetUser() driver: Driver) {
    return driver;
  }

  @ApiOkResponse({ type: Driver })
  @Roles(ROLE.DRIVER)
  @Patch('me')
  async updateMe(@Body() dto: UpdateDriverDto, @GetUser() driver: Driver) {
    return this.driversService.updateMe(driver, dto);
  }

  @HttpCode(HttpStatus.NO_CONTENT)
  @Roles(ROLE.DRIVER)
  @Delete('me')
  async deleteMe(@GetUser() driver: Driver) {
    return this.driversService.deleteMe(driver);
  }

  @ApiOkResponse({ type: DriverWallet })
  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN)
  @Patch(':id/wallet/withdraw')
  async withdraw(@Id() id: string, @Body() dto: UpdateWalletDto) {
    return this.walletRepository.withdraw(id, dto.cost);
  }

  @ApiOkResponse({ type: Rating, isArray: true })
  @Roles(ROLE.EMPLOYEE, ROLE.ADMIN)
  @Get(':id/rating')
  async rating(@Id() id: string) {
    return this.driversService.allratingForDriver(id);
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
  async delete(@Id() id: string) {
    return this.driversService.delete(id);
  }
}
