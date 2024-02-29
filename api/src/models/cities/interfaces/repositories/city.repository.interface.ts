import { FindOptionsRelations } from 'typeorm';
import { CreateCityDto, UpdateCityDto } from '../../dtos';
import { City } from '../../entities/city.entity';

export interface ICityRepository {
  create(dto: CreateCityDto): Promise<City>;
  find(ids?: string[]): Promise<City[]>;
  findOneById(
    id: string,
    withDeleted?: boolean,
    relations?: FindOptionsRelations<City>,
  ): Promise<City>;
  findForDeleteById(id: string, withDeleted: boolean): Promise<City>;
  update(city: City, dto: UpdateCityDto): Promise<City>;
  remove(city: City): Promise<void>;
}
