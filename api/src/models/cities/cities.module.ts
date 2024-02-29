import { Module, Provider } from '@nestjs/common';
import { CitiesService } from './services/cities.service';
import { CitiesController } from './controllers/cities.controller';
import { CityRepository } from './repositories/city.repository';
import { CITY_TYPES } from './interfaces/type';
import { City } from './entities/city.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

export const CitiesServiceProvider: Provider = {
  provide: CITY_TYPES.service,
  useClass: CitiesService,
};
export const CityRepositoryProvider: Provider = {
  provide: CITY_TYPES.repository,
  useClass: CityRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([City])],
  controllers: [CitiesController],
  providers: [CityRepositoryProvider, CitiesServiceProvider],
  exports: [CitiesServiceProvider, CityRepositoryProvider],
})
export class CitiesModule {}
