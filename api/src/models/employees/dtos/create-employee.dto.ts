import { ApiProperty } from '@nestjs/swagger';
import { IsString, Length, IsNotEmpty, IsOptional, Matches } from 'class-validator';
import { IsPhotoExist, IsUnique } from '@common/decorators';
import { Entities } from '@common/enums';
import { Transform } from 'class-transformer';
import { getPhotoPath } from '@common/helpers';
import { item_already_exist } from '@common/constants';

export class CreateEmployeeDto {
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
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @Matches(/^09[345689]\d{7}$/)
  @IsUnique(Entities.Employee, { message: item_already_exist('Phone') })
  readonly phone: string;

  @ApiProperty()
  @IsString()
  readonly address: string;

  @ApiProperty({ required: false })
  @IsOptional()
  @IsString()
  @Transform(({ value }: { value: string }) => getPhotoPath(value))
  @IsPhotoExist()
  readonly photo?: string;

  @ApiProperty()
  @IsString()
  @Length(6, 15)
  readonly password: string;
}
