// create-car.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsNotEmpty, IsString, IsUUID } from 'class-validator';
import { item_not_found } from '@common/constants';
import { IsPhotoExist } from '@common/decorators';
import { Entities } from '@common/enums';
import { getPhotoPath } from '@common/helpers';

export class CreateCarDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  model: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  brand: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  color: string;

  @ApiProperty()
  @IsString({ message: 'Please provide a photo' })
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo) })
  readonly photo: string;

  @ApiProperty()
  @IsUUID('all', { each: true })
  advantages: string[];
}
