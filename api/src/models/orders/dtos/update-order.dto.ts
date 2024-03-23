import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import {
  IsNotEmpty,
  IsNumber,
  IsString,
  ValidateNested,
} from 'class-validator';
import { item_not_found } from '../../../common/constants';
import { IsPhotoExist } from '../../../common/decorators';
import { Entities } from '../../../common/enums';
import { getPhotosPath } from '../../../common/helpers';
import { LocationDto } from './create-order.dto';

export class UpdateOrderDto {
  @ApiProperty()
  @IsNotEmpty()
  receiving_date?: Date;

  @ApiProperty({ default: 'waiting' })
  @IsString()
  status?: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsNumber()
  cost?: number;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationStart?: LocationDto;

  @ApiProperty()
  @ValidateNested()
  @Type(() => LocationDto)
  locationEnd?: LocationDto;

  @ApiProperty()
  @IsString({ message: 'Please provide a photo' })
  @Transform(({ value }: { value: string[] }) => getPhotosPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo) })
  readonly photo?: string[];
}
