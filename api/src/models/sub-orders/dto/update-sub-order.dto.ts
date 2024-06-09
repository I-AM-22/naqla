import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsOptional } from 'class-validator';
import { Car } from '@models/drivers/entities/car.entity';

export class UpdateSubOrderDto {
  @ApiProperty()
  @IsOptional()
  @IsNumber()
  rating?: number;
  @ApiProperty()
  @IsOptional()
  car?: Car;
}
