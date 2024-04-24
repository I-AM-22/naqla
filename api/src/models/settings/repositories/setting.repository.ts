import { Repository } from 'typeorm';
import { Setting } from '../entities/setting.entity';
import { ISettingRepository } from '../interfaces/repositories/setting.repository.interface';
import { InjectRepository } from '@nestjs/typeorm';
import { Injectable } from '@nestjs/common';

@Injectable()
export class SettingRepository implements ISettingRepository {
  constructor(
    @InjectRepository(Setting)
    private readonly settingRepository: Repository<Setting>,
  ) {}
  async find(): Promise<Setting[]> {
    return this.settingRepository.find();
  }

  async findOneByName(name: string): Promise<Setting> {
    return this.settingRepository.findOne({ where: { name } });
  }

  async findOneById(id: string): Promise<Setting> {
    return this.settingRepository.findOne({ where: { id } });
  }
}
