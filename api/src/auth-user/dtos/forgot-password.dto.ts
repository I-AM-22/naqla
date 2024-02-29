import { IsNotEmpty, Matches } from 'class-validator';
import { IsExist } from '../../common/decorators';
import { Entities } from '../../common/enums';
import { ApiProperty } from '@nestjs/swagger';
import { item_not_found } from '../../common/constants';

export class ForgotPasswordDto {
  @ApiProperty({ default: '0962535253' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Matches(/^09\d{8}$/)
  @IsExist(Entities.User, { message: item_not_found(Entities.User) })
  readonly phone: string;
}
