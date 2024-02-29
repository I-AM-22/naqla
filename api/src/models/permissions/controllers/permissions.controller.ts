import {
  Controller,
  Get,
  Param,
  UseGuards,
  SerializeOptions,
  ParseUUIDPipe,
  Inject,
} from '@nestjs/common';
import { Permission } from '../entities/permission.entity';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
  OmitType,
} from '@nestjs/swagger';
import { CaslAbilitiesGuard } from '../../../common/guards';
import { CheckAbilities } from '../../../common/decorators';
import { Action, Entities, GROUPS } from '../../../common/enums';
import {
  bad_req,
  data_not_found,
  denied_error,
} from '../../../common/constants';
import { IPermissionsService } from '../interfaces/services/permissions.service.interface';
import { PERMISSION_TYPES } from '../interfaces/type';

@ApiTags('Permissions')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@CheckAbilities({ action: Action.Manage, subject: Entities.Permission })
@UseGuards(CaslAbilitiesGuard)
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
  findOne(@Param('id', ParseUUIDPipe) id: string) {
    return this.permissionsService.findOne(id);
  }
}
