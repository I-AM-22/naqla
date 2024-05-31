// create-car.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsBoolean,
  IsNotEmpty,
  IsNumber,
  IsString,
  IsUUID,
  // IsUUID,
  ValidateNested,
} from 'class-validator';
import { item_not_found } from '../../../common/constants';
import { IsPhotoExist } from '../../../common/decorators';
import { Entities } from '../../../common/enums';
import { getPhotosPath } from '../../../common/helpers';

export class LocationDto {
  @ApiProperty()
  @IsNumber()
  longitude: number;

  @ApiProperty()
  @IsNumber()
  latitude: number;

  @ApiProperty()
  @IsString()
  region: string;

  @ApiProperty()
  @IsString()
  street: string;
}

export class CreateOrderDto {
  @ApiProperty()
  @IsNotEmpty()
  desiredDate: Date;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationStart: LocationDto;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationEnd: LocationDto;

  @ApiProperty({ default: 0 })
  @IsNumber()
  porters: number;

  @ApiProperty()
  @IsString({ message: 'Please provide a photo', each: true })
  @Transform(({ value }: { value: string[] }) => getPhotosPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo), each: true })
  readonly photo: string[];

  @ApiProperty()
  @IsUUID('all', { each: true })
  advantages: string[];
}
