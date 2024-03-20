import { Module, Provider } from '@nestjs/common';
import { AdvantagesController } from './controllers/advantages.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Advantage } from './entities/advantage.entity';
import { ADVANTAGE_TYPES } from './interfaces/type';
import { AdvantageRepository } from './repositories/advantage.repository';
import { AdvantagesService } from './services/advantages.service';

export const AdvantagesServiceProvider: Provider = {
  provide: ADVANTAGE_TYPES.service,
  useClass: AdvantagesService,
};
export const AdvantageRepositoryProvider: Provider = {
  provide: ADVANTAGE_TYPES.repository,
  useClass: AdvantageRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Advantage])],
  controllers: [AdvantagesController],
  providers: [AdvantageRepositoryProvider, AdvantagesServiceProvider],
  exports: [AdvantageRepositoryProvider, AdvantagesServiceProvider],
})
export class AdvantagesModule {}
