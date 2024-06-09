import { Injectable } from '@nestjs/common';
import { Setting } from '@models/settings/entities/setting.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { settings } from './data';

/**
 * Service dealing with setting based operations.
 *
 * @class
 */
@Injectable()
export class SettingSeederService {
  /**
   * Create an instance of class.
   *
   * @constructs
   *
   * @param {Repository<Setting>} settingRepository
   */
  constructor(
    @InjectRepository(Setting)
    private readonly settingRepository: Repository<Setting>,
  ) {}
  /**
   * Seed all settings.
   *
   * @function
   */
  create(): Array<Promise<Setting>> {
    return settings.map(async (setting: any) => {
      return await this.settingRepository
        .findOne({
          where: {
            name: setting.name,
          },
        })
        .then(async (dbSetting) => {
          // We check if a setting already exists.
          // If it does don't create a new one.
          if (dbSetting) {
            return Promise.resolve(null);
          }
          return Promise.resolve(
            // or create(setting).then(() => { ... });
            await this.settingRepository.save(setting),
          );
        })
        .catch((error) => Promise.reject(error));
    });
  }
}
