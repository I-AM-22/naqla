import { Injectable } from '@nestjs/common';
import { Repository, FindOptionsRelations } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { ICityRepository } from '../interfaces/repositories/city.repository.interface';
import { CreateCityDto, UpdateCityDto } from '../dtos';
import { City } from '../entities/city.entity';

@Injectable()
export class CityRepository implements ICityRepository {
  constructor(@InjectRepository(City) private cityRepo: Repository<City>) {}

  async create(dto: CreateCityDto): Promise<City> {
    const city = this.cityRepo.create(dto);
    await this.cityRepo.insert(dto);
    return city;
  }
  async find(ids?: string[]): Promise<City[]> {
    const cities = this.cityRepo.createQueryBuilder('city');
    if (ids) cities.andWhereInIds(ids);

    return cities.getMany();
  }

  async findOneById(
    id: string,
    withDeleted?: boolean,
    relations?: FindOptionsRelations<City>,
  ): Promise<City> {
    return this.cityRepo.findOne({
      where: { id },
      withDeleted,
      relations,
    });
  }

  async findForDeleteById(id: string, withDeleted: boolean): Promise<City> {
    return this.cityRepo.findOne({
      where: { id },

      withDeleted,
    });
  }

  async update(city: City, dto: UpdateCityDto) {
    Object.assign(city, dto);
    await city.save();
    return this.findOneById(city.id);
  }

  async remove(city: City): Promise<void> {
    this.cityRepo.softRemove(city);
    return;
  }
}
