import { Controller, Get, Inject } from '@nestjs/common';
import { ISettingsService } from '../interfaces/services/settings.service.interface';
import { SETTING_TYPES } from '../interfaces/type';
import { Id } from '../../../common/decorators';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Setting } from '../entities/setting.entity';

@ApiTags('Settings')
@Controller('settings')
export class SettingsController {
  constructor(
    @Inject(SETTING_TYPES.service) private settingsService: ISettingsService,
  ) {}

  @ApiOkResponse({ type: Setting, isArray: true })
  @Get()
  findAll() {
    return this.settingsService.find();
  }

  @ApiOkResponse({ type: Setting })
  @Get(':id')
  findOne(@Id() id: string) {
    return this.settingsService.findOneById(id);
  }
}
