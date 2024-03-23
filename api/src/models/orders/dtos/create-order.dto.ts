// create-car.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsNotEmpty,
  IsNumber,
  IsString,
  IsUUID,
  ValidateNested,
} from 'class-validator';
import { item_not_found } from '../../../common/constants';
import { IsPhotoExist } from '../../../common/decorators';
import { Entities } from '../../../common/enums';
import { getPhotoPath } from '../../../common/helpers';

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
  receiving_date: Date;

  @ApiProperty({ default: 'waiting' })
  @IsString()
  status: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  cost?: number;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationStart: LocationDto;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationEnd: LocationDto;

  @ApiProperty()
  @IsNotEmpty()
  @IsUUID('all', { each: true })
  userId: string;

  @ApiProperty()
  @IsString({ message: 'Please provide a photo' })
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo) })
  readonly photo: string[];
}
