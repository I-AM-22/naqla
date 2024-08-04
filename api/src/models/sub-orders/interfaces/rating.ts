import { ApiProperty } from '@nestjs/swagger';

export class Rating {
  @ApiProperty({ default: 4 })
  rating: number;
  @ApiProperty({ default: 'Good' })
  note: string;
  @ApiProperty({ default: 'adel' })
  firstname: string;
  @ApiProperty({ default: 'seirafi' })
  lastname: string;
  @ApiProperty()
  repeatdriver: boolean;
}
