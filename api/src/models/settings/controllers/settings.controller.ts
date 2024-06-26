import { Body, Controller, Get, Inject, Patch } from '@nestjs/common';
import { ISettingsService } from '../interfaces/services/settings.service.interface';
import { SETTING_TYPES } from '../interfaces/type';
import { ApiMainErrorsResponse, Auth, Id, Roles } from '@common/decorators';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Setting } from '../entities/setting.entity';
import { ROLE } from '@common/enums';
import { UpdateSettingDto } from '../dtos';

@ApiTags('Settings')
@Auth()
@ApiMainErrorsResponse()
@Roles(ROLE.ADMIN, ROLE.EMPLOYEE)
@Controller('settings')
export class SettingsController {
  constructor(@Inject(SETTING_TYPES.service) private settingsService: ISettingsService) {}

  @ApiOkResponse({ type: Setting, isArray: true })
  @Get()
  findAll() {
    return this.settingsService.find();
  }

  @ApiOkResponse({ type: Setting })
  @Get(':id')
  findOne(@Id() id: string) {
    return this.settingsService.findById(id);
  }

  @ApiOkResponse({ type: Setting })
  @Patch(':id')
  update(@Id() id: string, @Body() dto: UpdateSettingDto) {
    return this.settingsService.update(id, dto);
  }
}
