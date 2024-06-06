import { ApiProperty } from '@nestjs/swagger';
import { Driver } from '@models/drivers/entities/driver.entity';

export abstract class AuthDriverResponse {
  @ApiProperty()
  token: string;

  @ApiProperty({ type: Driver })
  driver: Driver;
}
