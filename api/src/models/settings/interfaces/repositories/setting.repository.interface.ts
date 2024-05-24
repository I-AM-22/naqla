import { Setting } from '../../entities/setting.entity';

export interface ISettingRepository {
  find(): Promise<Setting[]>;
  findOneByName(name: string): Promise<Setting>;
  findById(id: string): Promise<Setting>;
}
