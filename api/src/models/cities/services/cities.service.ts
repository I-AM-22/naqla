import { Inject, Injectable, NotFoundException } from '@nestjs/common';
import { CreateCityDto } from '../dtos';
import { UpdateCityDto } from '../dtos';
import { City } from '../entities/city.entity';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';
import { ICityRepository } from '../interfaces/repositories/city.repository.interface';
import { CITY_TYPES } from '../interfaces/type';
import { PaginatedResponse } from '@common/types';

@Injectable()
export class CitiesService {
  constructor(@Inject(CITY_TYPES.repository) private cityRepository: ICityRepository) {}
  async create(dto: CreateCityDto) {
    const city = this.cityRepository.create(dto);
    return city;
  }

  async find(ids?: string[]): Promise<PaginatedResponse<City> | City[]> {
    const cities = await this.cityRepository.find(ids);
    if (ids && ids.length !== cities.length) throw new NotFoundException('some of cities not found');

    return cities;
  }

  async findOne(id: string, withDeleted?: boolean): Promise<City> {
    const city = await this.cityRepository.findById(id, withDeleted);
    if (!city) throw new NotFoundException(item_not_found(Entities.City));
    return city;
  }

  async update(id: string, dto: UpdateCityDto): Promise<City> {
    const city = await this.findOne(id);
    return this.cityRepository.update(city, dto);
  }

  // async recover(id: string): Promise<City> {
  //   const city = await this.cityRepository.findForDeleteById(id, true);
  //   if (!city) throw new NotFoundException(item_not_found(Entities.Category));
  //   return city.recover();
  // }

  async delete(id: string): Promise<void> {
    const city = await this.findOne(id);
    this.cityRepository.delete(city);
    return;
  }
}
