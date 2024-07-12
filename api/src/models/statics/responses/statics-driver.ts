import { Driver } from '@models/drivers/entities/driver.entity';
import { ApiProperty } from '@nestjs/swagger';

export class StaticsDriver extends Driver {
  @ApiProperty()
  countOrderDelivered: number;
  @ApiProperty()
  countCar: number;
  @ApiProperty({ default: 4 })
  rating: number;
}
