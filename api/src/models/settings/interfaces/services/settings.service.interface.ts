import { UpdateSettingDto } from '../../dtos';
import { Setting } from '../../entities/setting.entity';

export interface ISettingsService {
  find(): Promise<Setting[]>;
  findOneByName(name: string): Promise<Setting>;
  findById(id: string): Promise<Setting>;
  update(id: string, dto: UpdateSettingDto): Promise<Setting>;
}
