import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { SETTING_TYPES } from '../interfaces/type';
import { Setting } from '../entities/setting.entity';
import { ISettingRepository } from '../interfaces/repositories/setting.repository.interface';
import { UpdateSettingDto } from '../dtos';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';

@Injectable()
export class SettingsService {
  constructor(
    @Inject(SETTING_TYPES.repository)
    private settingRepository: ISettingRepository,
  ) {}

  async find(): Promise<Setting[]> {
    return this.settingRepository.find();
  }

  async findOneByName(name: string): Promise<Setting> {
    const setting = await this.settingRepository.findOneByName(name);
    if (!setting) throw new NotFoundException(item_not_found(Entities.Setting));
    return setting;
  }

  async findById(id: string): Promise<Setting> {
    const setting = await this.settingRepository.findById(id);
    if (!setting) throw new NotFoundException(item_not_found(Entities.Setting));
    return setting;
  }

  async update(id: string, dto: UpdateSettingDto): Promise<Setting> {
    const setting = await this.findById(id);
    return this.settingRepository.update(setting, dto);
  }
}
