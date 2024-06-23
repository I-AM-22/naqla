import { PaginatedResponse } from '../../../../common/types';
import { CreateCityDto, UpdateCityDto } from '../../dtos';
import { City } from '../../entities/city.entity';

export interface ICitiesService {
  create(dto: CreateCityDto): Promise<City>;

  find(ids?: string[]): Promise<PaginatedResponse<City> | City[]>;

  findOne(id: string, withDeleted?: boolean): Promise<City>;

  update(id: string, dto: UpdateCityDto): Promise<City>;

  // recover(id: string): Promise<City>;

  delete(id: string): Promise<void>;
}
