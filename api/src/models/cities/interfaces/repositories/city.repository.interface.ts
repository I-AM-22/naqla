import { FindOptionsRelations } from 'typeorm';
import { CreateCityDto, UpdateCityDto } from '../../dtos';
import { City } from '../../entities/city.entity';

export interface ICityRepository {
  create(dto: CreateCityDto): Promise<City>;
  find(ids?: string[]): Promise<City[]>;
  findById(id: string, withDeleted?: boolean, relations?: FindOptionsRelations<City>): Promise<City>;
  findForDeleteById(id: string, withDeleted: boolean): Promise<City>;
  update(city: City, dto: UpdateCityDto): Promise<City>;
  delete(city: City): Promise<void>;
}
