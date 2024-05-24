import { Inject, Injectable } from '@nestjs/common';
import { ISettingsService } from '../interfaces/services/settings.service.interface';
import { SETTING_TYPES } from '../interfaces/type';
import { Setting } from '../entities/setting.entity';
import { ISettingRepository } from '../interfaces/repositories/setting.repository.interface';

@Injectable()
export class SettingsService implements ISettingsService {
  constructor(
    @Inject(SETTING_TYPES.repository)
    private settingRepository: ISettingRepository,
  ) {}

  async find(): Promise<Setting[]> {
    return this.settingRepository.find();
  }

  async findOneByName(name: string): Promise<Setting> {
    return this.settingRepository.findOneByName(name);
  }

  async findById(id: string): Promise<Setting> {
    return this.settingRepository.findById(id);
  }
}
