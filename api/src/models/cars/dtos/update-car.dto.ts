// create-car.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform } from 'class-transformer';
import { IsNotEmpty, IsOptional, IsString, IsUUID } from 'class-validator';
import { item_not_found } from '@common/constants';
import { IsPhotoExist } from '@common/decorators';
import { Entities } from '@common/enums';
import { getPhotoPath } from '@common/helpers';

export class UpdateCarDto {
  @ApiProperty()
  @IsOptional()
  @IsNotEmpty()
  @IsString()
  readonly model: string;

  @ApiProperty()
  @IsOptional()
  @IsNotEmpty()
  @IsString()
  readonly brand: string;

  @ApiProperty()
  @IsOptional()
  @IsNotEmpty()
  @IsString()
  readonly color: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo) })
  readonly photo: string;

  @ApiProperty()
  @IsOptional()
  @IsUUID('all', { each: true })
  readonly advantageIds: string[];
}
