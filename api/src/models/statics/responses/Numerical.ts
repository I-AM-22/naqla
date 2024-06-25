import { ApiProperty } from '@nestjs/swagger';

export class Numerical {
  @ApiProperty()
  user: number;

  @ApiProperty()
  driver: number;

  @ApiProperty()
  orderWaiting: number;

  @ApiProperty()
  orderCompleted: number;

  @ApiProperty()
  orderActive: number;

  @ApiProperty()
  subOrderCompleted: number;

  @ApiProperty()
  subOrderActive: number;

  @ApiProperty()
  car: number;
}
