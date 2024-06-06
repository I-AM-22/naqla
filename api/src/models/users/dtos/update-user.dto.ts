import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, Length } from 'class-validator';
import { IsPhotoExist } from '@common/decorators';
import { Entities } from '@common/enums';
import { Transform } from 'class-transformer';
import { getPhotoPath } from '@common/helpers';
import { item_not_found } from '@common/constants';

export class UpdateUserDto {
  @ApiProperty({ default: 'bahaa Alden' })
  @IsOptional()
  @IsString()
  @Length(3, 16)
  readonly firstName: string;

  @ApiProperty({ default: 'Abdo' })
  @IsOptional()
  @IsString()
  @Length(3, 16)
  readonly lastName: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist({ message: item_not_found(Entities.Photo) })
  readonly photo: string;
}
