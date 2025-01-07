import { Module, Provider } from '@nestjs/common';
import { SettingsService } from './services/settings.service';
import { SettingsController } from './controllers/settings.controller';
import { SETTING_TYPES } from './interfaces/type';
import { SettingRepository } from './repositories/setting.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Setting } from './entities/setting.entity';

export const SettingRepositoryProvider: Provider = {
  provide: SETTING_TYPES.repository,
  useClass: SettingRepository,
};

@Module({
  imports: [TypeOrmModule.forFeature([Setting])],
  controllers: [SettingsController],
  providers: [SettingsService, SettingRepositoryProvider],
  exports: [SettingsService, SettingRepositoryProvider],
})
export class SettingsModule {}
