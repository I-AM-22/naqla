import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  ParseUUIDPipe,
  HttpCode,
  HttpStatus,
  Inject,
} from '@nestjs/common';
import { CreateCityDto } from '../dtos';
import { UpdateCityDto } from '../dtos';
import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { CaslAbilitiesGuard } from '../../../common/guards';
import { CheckAbilities } from '../../../common/decorators';
import { Action, Entities } from '../../../common/enums';
import { City } from '../entities/city.entity';
import { ICrud } from '../../../common/interfaces';
import {
  bad_req,
  data_not_found,
  denied_error,
} from '../../../common/constants';
import { ICitiesService } from '../interfaces/services/cities.service.interface';
import { CITY_TYPES } from '../interfaces/type';

@ApiTags('cities')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseGuards(CaslAbilitiesGuard)
@Controller({ path: 'cities', version: '1' })
export class CitiesController implements ICrud<City> {
  constructor(
    @Inject(CITY_TYPES.service) private readonly citiesService: ICitiesService,
  ) {}

  @CheckAbilities({ action: Action.Manage, subject: Entities.City })
  @ApiCreatedResponse({ description: 'city has created', type: City })
  @Post()
  create(@Body() dto: CreateCityDto) {
    return this.citiesService.create(dto);
  }

  @ApiOkResponse({ type: City, isArray: true, description: 'get all cities' })
  @Get()
  find() {
    return this.citiesService.find();
  }

  @ApiOkResponse({ type: City, description: 'get one city' })
  @Get(':id')
  findOne(@Param('id', ParseUUIDPipe) id: string) {
    return this.citiesService.findOne(id);
  }

  @CheckAbilities({ action: Action.Update, subject: Entities.City })
  @ApiOkResponse({ type: City, description: 'update city' })
  @Patch(':id')
  update(@Param('id', ParseUUIDPipe) id: string, @Body() dto: UpdateCityDto) {
    return this.citiesService.update(id, dto);
  }

  // @CheckAbilities({ action: Action.Update, subject: Entities.City })
  // @ApiOkResponse({ type: City, description: 'recover deleted city' })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // recover(@Param('id', ParseUUIDPipe) id: string) {
  //   return this.citiesService.recover(id);
  // }

  @CheckAbilities({ action: Action.Delete, subject: Entities.City })
  @ApiNoContentResponse({ description: 'delete City' })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  remove(@Param('id', ParseUUIDPipe) id: string) {
    return this.citiesService.remove(id);
  }
}
