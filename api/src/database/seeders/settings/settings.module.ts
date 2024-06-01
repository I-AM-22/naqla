import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SettingSeederService } from './settings.service';
import { Setting } from '../../../models/settings';

@Module({
  imports: [TypeOrmModule.forFeature([Setting])],
  providers: [SettingSeederService],
  exports: [SettingSeederService],
})
export class SettingsSeederModule {}
