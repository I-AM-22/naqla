import { IsString, Length } from 'class-validator';
import { IsUnique } from '@common/decorators';
import { Entities } from '@common/enums';
import { ApiProperty } from '@nestjs/swagger';
import { item_already_exist } from '@common/constants';

export class CreateCityDto {
  @ApiProperty()
  @Length(3)
  @IsString()
  @IsUnique(Entities.City, { message: item_already_exist('city') })
  name: string;
}
