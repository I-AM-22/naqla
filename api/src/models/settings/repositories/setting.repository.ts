import { Repository } from 'typeorm';
import { Setting } from '../entities/setting.entity';
import { ISettingRepository } from '../interfaces/repositories/setting.repository.interface';
import { InjectRepository } from '@nestjs/typeorm';
import { Injectable } from '@nestjs/common';
import { UpdateSettingDto } from '../dtos';

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

  async findById(id: string): Promise<Setting> {
    return this.settingRepository.findOne({ where: { id } });
  }

  async update(setting: Setting, dto: UpdateSettingDto): Promise<Setting> {
    setting.cost = dto.cost;
    return await setting.save();
  }
}
