import { ApiProperty } from '@nestjs/swagger';
import { Driver } from '../../models/drivers';

export abstract class AuthDriverResponse {
  @ApiProperty()
  token: string;

  @ApiProperty({ type: Driver })
  driver: Driver;
}
