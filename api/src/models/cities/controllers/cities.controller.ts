import { Controller, Get, Post, Body, Patch, Delete, HttpCode, HttpStatus, Inject } from '@nestjs/common';
import { CreateCityDto } from '../dtos';
import { UpdateCityDto } from '../dtos';
import { ApiCreatedResponse, ApiNoContentResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, CheckAbilities, Id } from '@common/decorators';
import { Action, Entities } from '@common/enums';
import { City } from '../entities/city.entity';
import { ICrud } from '@common/interfaces';
import { ICitiesService } from '../interfaces/services/cities.service.interface';
import { CITY_TYPES } from '../interfaces/type';
import { PaginatedCityResponse } from '../responses/pagination.response';

@ApiTags('Cities')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'cities', version: '1' })
export class CitiesController implements ICrud<City> {
  constructor(@Inject(CITY_TYPES.service) private readonly citiesService: ICitiesService) {}

  @CheckAbilities({ action: Action.Manage, subject: Entities.City })
  @ApiCreatedResponse({ description: 'city has created', type: City })
  @Post()
  create(@Body() dto: CreateCityDto) {
    return this.citiesService.create(dto);
  }

  @ApiOkResponse({ type: PaginatedCityResponse, description: 'get all cities' })
  @Get()
  find() {
    return this.citiesService.find();
  }

  @ApiOkResponse({ type: City, description: 'get one city' })
  @Get(':id')
  findOne(@Id() id: string) {
    return this.citiesService.findOne(id);
  }

  @CheckAbilities({ action: Action.Update, subject: Entities.City })
  @ApiOkResponse({ type: City, description: 'update city' })
  @Patch(':id')
  update(@Id() id: string, @Body() dto: UpdateCityDto) {
    return this.citiesService.update(id, dto);
  }

  // @CheckAbilities({ action: Action.Update, subject: Entities.City })
  // @ApiOkResponse({ type: City, description: 'recover deleted city' })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // recover(@Id() id: string) {
  //   return this.citiesService.recover(id);
  // }

  @CheckAbilities({ action: Action.Delete, subject: Entities.City })
  @ApiNoContentResponse({ description: 'delete City' })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  delete(@Id() id: string) {
    return this.citiesService.delete(id);
  }
}
