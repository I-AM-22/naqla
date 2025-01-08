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
} from '@nestjs/common';
import { ApiTags, ApiOkResponse, ApiQuery, ApiNoContentResponse } from '@nestjs/swagger';

import { UpdateUserDto } from '../dtos';
import { User } from '../entities/user.entity';
import { GetUser, Roles, CheckAbilities, Id, ApiMainErrorsResponse, Auth } from '@common/decorators';
import { GROUPS, ROLE, Entities, Action } from '@common/enums';
import { LoggingInterceptor, WithDeletedInterceptor } from '@common/interceptors';
import { PaginatedResponse } from '@common/types';
import { Request } from 'express';
import { UpdateWalletDto } from '@models/drivers/dtos/update-wallet.dto ';
import { UserWalletRepository } from '../repositories/user-wallet.repository';
import { PaginatedUserResponse } from '../responses/pagination.response';
import { UsersService } from '../services/users.service';

@ApiTags('Users')
@Auth()
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'users', version: '1' })
export class UsersController {
  constructor(
    private usersService: UsersService,
    private walletRepository: UserWalletRepository,
  ) {}

  @UseInterceptors(WithDeletedInterceptor)
  // @SerializeOptions({ groups: [GROUPS.ALL_USERS] })
  @ApiOkResponse({ type: PaginatedUserResponse })
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
    return this.usersService.find(page, limit, active, withDeleted);
  }

  @UseInterceptors(WithDeletedInterceptor)
  @SerializeOptions({ groups: [GROUPS.ALL_USERS] })
  @ApiOkResponse({ type: PaginatedResponse<User> })
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
  @ApiOkResponse({ type: User })
  @SerializeOptions({ groups: [GROUPS.USER] })
  @Roles(ROLE.USER)
  @Get('myPhotos')
  async getMyPhotos(@GetUser() user: User) {
    return this.usersService.getMyPhotos(user);
  }

  @ApiOkResponse({ type: User })
  @Roles(ROLE.USER)
  @Get('me')
  async getMe(@GetUser() user: User) {
    return user;
  }

  @ApiOkResponse({ type: User })
  @SerializeOptions({ groups: [GROUPS.USER] })
  @Roles(ROLE.USER)
  @Patch('me')
  async updateMe(@Body() dto: UpdateUserDto, @GetUser() user: User) {
    return this.usersService.updateMe(user, dto);
  }

  @ApiNoContentResponse()
  @HttpCode(HttpStatus.NO_CONTENT)
  @SerializeOptions({ groups: [GROUPS.USER] })
  @Roles(ROLE.USER)
  @Delete('me')
  async deleteMe(@GetUser() user: User) {
    return this.usersService.deleteMe(user);
  }

  @ApiOkResponse({ type: User })
  @Patch(':id/wallet/withdraw')
  async withdraw(@Id() id: string, @Body() dto: UpdateWalletDto) {
    return this.walletRepository.withdraw(id, dto.cost);
  }

  @ApiOkResponse({ type: User })
  @Patch(':id/wallet/deposit')
  async deposit(@Id() id: string, @Body() dto: UpdateWalletDto) {
    return this.walletRepository.deposit(id, dto.cost);
  }

  @ApiOkResponse({ type: User })
  @SerializeOptions({ groups: [GROUPS.USER] })
  @Get(':id')
  async findOne(@Id() id: string) {
    return this.usersService.findOne(id);
  }

  @ApiOkResponse({ type: User })
  @SerializeOptions({ groups: [GROUPS.USER] })
  @CheckAbilities({ action: Action.Update, subject: Entities.User })
  @Patch(':id')
  async update(@Id() id: string, @Body() dto: UpdateUserDto) {
    return this.usersService.update(id, dto);
  }

  @ApiNoContentResponse()
  @CheckAbilities({ action: Action.Delete, subject: Entities.User })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  async delete(@Id() id: string) {
    return this.usersService.delete(id);
  }

  // @ApiOperation({ summary: 'recover deleted user' })
  // @CheckAbilities({ action: Action.Update, subject: Entities.User })
  // @SerializeOptions({ groups: [GROUPS.USER] })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // async recover(@Id() id: string) {
  //   return this.usersService.recover(id);
  // }
}
