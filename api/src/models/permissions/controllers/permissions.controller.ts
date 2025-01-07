import { Controller, Get, SerializeOptions } from '@nestjs/common';
import { Permission } from '../entities/permission.entity';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, CheckAbilities, Id } from '@common/decorators';
import { Action, Entities, GROUPS } from '@common/enums';
import { PermissionsService } from '../services/permissions.service';

@ApiTags('Permissions')
@Auth()
@ApiMainErrorsResponse()
@CheckAbilities({ action: Action.Manage, subject: Entities.Permission })
@Controller({ path: 'permissions', version: '1' })
export class PermissionsController {
  constructor(public permissionsService: PermissionsService) {}
  @ApiOkResponse({
    type: Permission,
    isArray: true,
  })
  @SerializeOptions({ groups: [GROUPS.ALL_PERMISSIONS] })
  @Get('')
  find() {
    return this.permissionsService.find();
  }

  @ApiOkResponse({ type: Permission })
  @SerializeOptions({ groups: [GROUPS.PERMISSION] })
  @Get(':id')
  findOne(@Id() id: string) {
    return this.permissionsService.findOne(id);
  }
}
