import { PaginatedResponse } from '@common/types';
import { ApiProperty } from '@nestjs/swagger';
import { City } from '../entities/city.entity';

export class PaginatedCityResponse extends PaginatedResponse<City> {
  @ApiProperty({ type: City, isArray: true })
  data: City[];
}
