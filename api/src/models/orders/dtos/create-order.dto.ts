// create-car.dto.ts

import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsDateString,
  IsNotEmpty,
  IsNumber,
  IsString,
  IsUUID,
  // IsUUID,
  ValidateNested,
} from 'class-validator';
import { item_not_found } from '@common/constants';
import { IsItemExist } from '@common/decorators';
import { Entities } from '@common/enums';
import { getItemsPath } from '@common/helpers';
import { Item } from '../interfaces/item.inteface';

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
  @IsDateString()
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

  @ApiProperty({ isArray: true, type: Item })
  @Transform(({ value }: { value: Item[] }) => getItemsPath(value))
  @IsItemExist({ message: item_not_found(Entities.Photo), each: true })
  @Type(() => Item)
  readonly items: Item[];

  @ApiProperty()
  @IsUUID('all', { each: true })
  advantages: string[];
}
