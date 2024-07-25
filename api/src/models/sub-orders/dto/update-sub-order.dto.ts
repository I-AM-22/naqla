import { IsBoolean, IsNumber, IsOptional, IsString } from 'class-validator';

import { ApiProperty } from '@nestjs/swagger';

export class UpdateSubOrderDto {
  @ApiProperty({ default: 1 })
  @IsOptional()
  @IsNumber()
  rating?: number;
  
  @ApiProperty()
  @IsOptional()
  @IsString()
  note?: string;

  @ApiProperty()
  @IsOptional()
  @IsBoolean()
  repeatDriver?: boolean;
}
