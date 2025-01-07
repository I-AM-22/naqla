import { Controller, Get, Post, Body, Patch, Delete, HttpCode, HttpStatus } from '@nestjs/common';
import { CreateCityDto } from '../dtos';
import { UpdateCityDto } from '../dtos';
import { ApiCreatedResponse, ApiNoContentResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, CheckAbilities, Id } from '@common/decorators';
import { Action, Entities } from '@common/enums';
import { City } from '../entities/city.entity';
import { ICrud } from '@common/interfaces';
import { PaginatedCityResponse } from '../responses/pagination.response';
import { CitiesService } from '../services/cities.service';

@ApiTags('Cities')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'cities', version: '1' })
export class CitiesController implements ICrud<City> {
  constructor(private readonly citiesService: CitiesService) {}

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
