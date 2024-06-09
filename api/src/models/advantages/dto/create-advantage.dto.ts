import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsString, Min } from 'class-validator';
import { IsUnique } from '@common/decorators';
import { Entities } from '@common/enums';
import { item_already_exist } from '@common/constants';

export class CreateAdvantageDto {
  @ApiProperty()
  @IsUnique(Entities.Advantage, {
    message: item_already_exist(Entities.Advantage),
  })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  @Min(0)
  cost: number;
}
