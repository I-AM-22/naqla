import { Controller, SerializeOptions, Get, Post, Body, Param, Patch, Delete } from '@nestjs/common';
import { ApiTags, ApiOkResponse, OmitType, ApiCreatedResponse, ApiOperation } from '@nestjs/swagger';

import { CreateRoleDto, UpdateRoleDto } from '../dtos';
import { Role } from '../entities/role.entity';
import { ApiMainErrorsResponse, Auth, CheckAbilities, Id } from '@common/decorators';
import { Action, Entities, GROUPS } from '@common/enums';
import { RolesService } from '../services/roles.service';

@ApiTags('Roles')
@Auth()
@ApiMainErrorsResponse()
@CheckAbilities({ action: Action.Manage, subject: Entities.Role })
@Controller({ path: 'roles', version: '1' })
export class RolesController {
  constructor(private rolesService: RolesService) {}

  @ApiOkResponse({ type: OmitType(Role, ['permissions']), isArray: true })
  @SerializeOptions({ groups: [GROUPS.ALL_ROLES] })
  @Get()
  async find(): Promise<Role[]> {
    return this.rolesService.find();
  }

  @ApiCreatedResponse({ type: Role })
  @SerializeOptions({ groups: [GROUPS.ROLE] })
  @Post()
  async create(@Body() dto: CreateRoleDto): Promise<Role> {
    return this.rolesService.create(dto);
  }

  @ApiOkResponse({ type: Role })
  @SerializeOptions({
    groups: [GROUPS.ROLE],
  })
  @Get(':id')
  async findOne(@Param('id') id: string): Promise<Role | undefined> {
    return this.rolesService.findOne(id);
  }

  @ApiOkResponse({ type: Role })
  @SerializeOptions({ groups: [GROUPS.ROLE] })
  @Patch(':id')
  async update(@Id() id: string, @Body() dto: UpdateRoleDto): Promise<Role | undefined> {
    return this.rolesService.update(id, dto);
  }

  @ApiOperation({ summary: 'add permissions to the role' })
  @ApiOkResponse({ type: Role })
  @SerializeOptions({ groups: [GROUPS.ROLE] })
  @Post(':id/permissions')
  async addPermissions(@Id() id: string, @Body() dto: UpdateRoleDto): Promise<Role | undefined> {
    return this.rolesService.addPermissions(id, dto);
  }

  @ApiOperation({ summary: 'remove permissions from the role' })
  @ApiOkResponse({ type: Role })
  @SerializeOptions({ groups: [GROUPS.ROLE] })
  @Delete(':id/permissions')
  async deletePermissions(@Id() id: string, @Body() dto: UpdateRoleDto): Promise<Role | undefined> {
    return this.rolesService.deletePermissions(id, dto);
  }
}
