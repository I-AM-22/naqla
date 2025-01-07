import { Module, Provider } from '@nestjs/common';
import { CitiesController } from './controllers/cities.controller';
import { CityRepository } from './repositories/city.repository';
import { CITY_TYPES } from './interfaces/type';
import { City } from './entities/city.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CitiesService } from './services/cities.service';

export const CityRepositoryProvider: Provider = {
  provide: CITY_TYPES.repository,
  useClass: CityRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([City])],
  controllers: [CitiesController],
  providers: [CityRepositoryProvider, CitiesService],
  exports: [CityRepositoryProvider, CitiesService],
})
export class CitiesModule {}
