import { ApiProperty } from '@nestjs/swagger';

export class StaticProfits {
  @ApiProperty()
  day: string;

  @ApiProperty()
  profits: number;
}
