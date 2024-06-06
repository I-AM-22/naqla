import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, Length, Matches } from 'class-validator';
import { IsUnique } from '@common/decorators';
import { Entities } from '@common/enums';
import { item_already_exist } from '@common/constants';

export class UpdatePhoneDto {
  @ApiProperty({ default: '0962535253' })
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Matches(/^09[345689]\d{7}$/)
  @IsUnique(Entities.User, { message: item_already_exist('Phone') })
  readonly phone: string;
}
