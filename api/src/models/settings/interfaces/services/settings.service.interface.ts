import { Setting } from '../../entities/setting.entity';

export interface ISettingsService {
  find(): Promise<Setting[]>;
  findOneByName(name: string): Promise<Setting>;
  findOneById(id: string): Promise<Setting>;
}
