import { IsNumber, IsOptional } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SetDriverSubOrderDto {
  @ApiProperty()
  @IsOptional()
  @IsNumber()
  rating?: number;

  @ApiProperty()
  @IsOptional()
  carId?: string;
}
