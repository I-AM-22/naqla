import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, Min } from 'class-validator';

export class CreateSettingDto {
  @ApiProperty()
  @IsNumber()
  @Min(0)
  cost: number;
}
