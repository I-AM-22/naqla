import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, Length, Matches } from 'class-validator';

export class ConfirmDto {
  @ApiProperty({ default: '123456' })
  @Length(6, 6, { message: 'Otp must contain 6 characters' })
  @IsNotEmpty()
  otp: string;

  @ApiProperty({ default: '0962535253' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @Matches(/^09[345689]\d{7}$/)
  readonly phone: string;
}
