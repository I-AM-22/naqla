import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Length, Matches } from 'class-validator';
import { IsUnique } from '../../../common/decorators';
import { Entities } from '../../../common/enums';
import { item_already_exist } from '../../../common/constants';

export class CreateUserDto {
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
  @IsUnique(Entities.Employee, { message: item_already_exist('phone') })
  @Matches(/^09\d{8}$/)
  readonly phone: string;

  @ApiProperty()
  @IsString()
  @Length(6, 15)
  readonly password: string;
}
