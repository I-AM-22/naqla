import { ApiMainErrorsResponse, Auth, Id, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { Body, Controller, Get, Inject, Patch } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { UpdateSettingDto } from '../dtos';
import { Setting } from '../entities/setting.entity';
import { ISettingsService } from '../interfaces/services/settings.service.interface';
import { SETTING_TYPES } from '../interfaces/type';

@ApiTags('Settings')
@Auth()
@ApiMainErrorsResponse()
@Roles(ROLE.SUPER_ADMIN)
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
