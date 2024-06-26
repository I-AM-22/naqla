import { PaginatedResponse } from '@common/types';
import { Driver } from '../entities/driver.entity';
import { ApiProperty } from '@nestjs/swagger';

export class PaginatedDriverResponse extends PaginatedResponse<Driver> {
  @ApiProperty({ type: Driver, isArray: true })
  data: Driver[];
}
