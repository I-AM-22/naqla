import { IsNumber, IsOptional } from 'class-validator';

import { ApiProperty } from '@nestjs/swagger';

export class UpdateSubOrderDto {
  @ApiProperty()
  @IsOptional()
  @IsNumber()
  rating?: number;
}
