import { ApiProperty } from '@nestjs/swagger';
export class AdvantageSuper {
  @ApiProperty()
  advantage: string;
  @ApiProperty()
  countUserUsed: number;
  @ApiProperty()
  countCarUsed: number;
}
