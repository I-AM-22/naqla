import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsOptional, Length, IsNotEmpty, Matches } from 'class-validator';
import { IsPhotoExist, IsUnique } from '@common/decorators';
import { Entities } from '@common/enums';
import { Transform } from 'class-transformer';
import { getPhotoPath } from '@common/helpers';
import { item_already_exist } from '@common/constants';

export class UpdateEmployeeDto {
  @IsString()
  @IsOptional()
  @Length(3, 16)
  @ApiProperty({ required: false })
  readonly name?: string;

  @ApiProperty({ default: '0962535253' })
  @IsOptional()
  @IsNotEmpty({ message: 'please provide phone number' })
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @Matches(/^09[345689]\d{7}$/)
  @IsUnique(Entities.User, { message: item_already_exist('Phone') })
  readonly phone: string;

  @ApiProperty()
  @IsOptional()
  @IsString()
  readonly address?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist()
  readonly photo?: string;

  @ApiProperty()
  @IsString()
  @IsOptional()
  @Length(6, 15)
  readonly password: string;
}
