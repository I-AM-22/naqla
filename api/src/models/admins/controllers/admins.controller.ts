import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Delete,
  HttpCode,
  HttpStatus,
  SerializeOptions,
  Inject,
} from '@nestjs/common';
import { UpdateAdminDto, CreateAdminDto, LoginAdminDto } from '../dtos';

import {
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { Admin } from '../entities/admin.entity';
import { Role } from '@models/roles/entities/role.entity';
import {
  Public,
  CheckAbilities,
  GetUser,
  Roles,
  Id,
  Auth,
} from '@common/decorators';
import { GROUPS, Entities, Action, ROLE } from '@common/enums';
import { ICrud } from '@common/interfaces';
import { AuthAdminResponse } from '../interfaces';
import { bad_req, denied_error, item_not_found } from '@common/constants';
import { IAdminsService } from '../interfaces/services/admins.service.interface';
import { ADMIN_TYPES } from '../interfaces/type';

@ApiTags('Admins')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: item_not_found('Data') })
@Auth()
@Controller({ path: 'admins', version: '1' })
export class AdminsController implements ICrud<Admin> {
  constructor(
    @Inject(ADMIN_TYPES.service) private readonly adminsService: IAdminsService,
  ) {}

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

  @ApiOkResponse({ type: Admin })
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
  remove(@Id() id: string) {
    return this.adminsService.remove(id);
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
