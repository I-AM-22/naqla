import { UpdateSettingDto } from '../../dtos';
import { Setting } from '../../entities/setting.entity';

export interface ISettingRepository {
  find(): Promise<Setting[]>;
  findOneByName(name: string): Promise<Setting>;
  findById(id: string): Promise<Setting>;
  update(setting: Setting, dto: UpdateSettingDto): Promise<Setting>;
}
