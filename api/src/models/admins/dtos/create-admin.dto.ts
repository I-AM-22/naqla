import { ApiProperty } from '@nestjs/swagger';
import {
  IsString,
  Length,
  IsNotEmpty,
  IsOptional,
  Matches,
} from 'class-validator';
import { IsPhotoExist, IsUnique } from '../../../common/decorators';
import { Transform } from 'class-transformer';
import { getPhotoPath } from '../../../common/helpers';
import { Entities } from '../../../common/enums';
import { item_already_exist } from '../../../common/constants';

export class CreateAdminDto {
  @ApiProperty({ default: 'bahaa Alden' })
  @IsString()
  @Length(3, 16)
  readonly firstName: string;

  @ApiProperty({ default: 'Abdo' })
  @IsString()
  @Length(3, 16)
  readonly lastName: string;

  @ApiProperty({ default: '0962535253' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Matches(/^09\d{8}$/)
  @IsUnique(Entities.Admin, { message: item_already_exist('phone') })
  readonly phone: string;

  @ApiProperty()
  @IsString()
  @Length(6, 15)
  readonly password: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist()
  readonly photo?: string;
}
