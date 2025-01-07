import { Body, Controller, Delete, Get, HttpCode, HttpStatus, Patch, Post, SerializeOptions } from '@nestjs/common';
import { CreateAdminDto, LoginAdminDto, UpdateAdminDto } from '../dtos';

import { ApiMainErrorsResponse, Auth, CheckAbilities, GetUser, Id, Public, Roles } from '@common/decorators';
import { Action, Entities, GROUPS, ROLE } from '@common/enums';
import { ICrud } from '@common/interfaces';
import { Role } from '@models/roles/entities/role.entity';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { Admin } from '../entities/admin.entity';
import { AuthAdminResponse } from '../interfaces';
import { AdminsService } from '../services/admins.service';

@ApiTags('Admins')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'admins', version: '1' })
export class AdminsController implements ICrud<Admin> {
  constructor(private readonly adminsService: AdminsService) {}

  @Public()
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: 'User logged in successfully',
    type: AuthAdminResponse,
  })
  @SerializeOptions({ groups: [GROUPS.ADMIN] })
  @HttpCode(HttpStatus.OK)
  @Post('login')
  login(@Body() dto: LoginAdminDto) {
    return this.adminsService.login(dto);
  }

  @ApiOkResponse({ type: Admin })
  @Roles(ROLE.ADMIN)
  @CheckAbilities({ action: Action.Create, subject: Entities.Admin })
  @SerializeOptions({ groups: [GROUPS.ADMIN] })
  @Post()
  create(@Body() createAdminDto: CreateAdminDto) {
    return this.adminsService.create(createAdminDto);
  }

  @ApiOkResponse({ type: Admin, isArray: true })
  @Roles(ROLE.ADMIN)
  @CheckAbilities({ action: Action.Read, subject: Entities.Admin })
  @SerializeOptions({ groups: [GROUPS.ALL_ADMINS] })
  @Get()
  find(@GetUser('role') role: Role) {
    return this.adminsService.find(role.name);
  }

  @ApiOkResponse({ type: Admin })
  @Roles(ROLE.ADMIN)
  @SerializeOptions({ groups: [GROUPS.ADMIN] })
  @CheckAbilities({ action: Action.Read, subject: Entities.Admin })
  @Get(':id')
  findOne(@Id() id: string, @GetUser('role') role: Role) {
    return this.adminsService.findOne(id, role.name);
  }

  @ApiOkResponse({ type: Admin })
  @Roles(ROLE.ADMIN)
  @SerializeOptions({ groups: [GROUPS.ADMIN] })
  @CheckAbilities({ action: Action.Update, subject: Entities.Admin })
  @Patch(':id')
  update(@Id() id: string, @Body() dto: UpdateAdminDto) {
    return this.adminsService.update(id, dto);
  }

  @CheckAbilities({ action: Action.Delete, subject: Entities.Admin })
  @Roles(ROLE.ADMIN)
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  delete(@Id() id: string) {
    return this.adminsService.delete(id);
  }

  // @ApiOperation({ summary: 'recover deleted admin' })
  // @CheckAbilities({ action: Action.Update, subject: Entities.Admin })
  // @SerializeOptions({ groups: [GROUPS.ADMIN] })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // recover(@Id() id: string) {
  //   return this.adminsService.recover(id);
  // }
}
