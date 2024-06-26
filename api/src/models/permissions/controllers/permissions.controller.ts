import { Controller, Get, SerializeOptions, Inject } from '@nestjs/common';
import { Permission } from '../entities/permission.entity';
import { ApiOkResponse, ApiTags, OmitType } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, CheckAbilities, Id } from '@common/decorators';
import { Action, Entities, GROUPS } from '@common/enums';
import { IPermissionsService } from '../interfaces/services/permissions.service.interface';
import { PERMISSION_TYPES } from '../interfaces/type';

@ApiTags('Permissions')
@Auth()
@ApiMainErrorsResponse()
@CheckAbilities({ action: Action.Manage, subject: Entities.Permission })
@Controller({ path: 'permissions', version: '1' })
export class PermissionsController {
  constructor(
    @Inject(PERMISSION_TYPES.service)
    public permissionsService: IPermissionsService,
  ) {}
  @ApiOkResponse({
    type: OmitType(Permission, ['createdAt', 'updatedAt']),
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
