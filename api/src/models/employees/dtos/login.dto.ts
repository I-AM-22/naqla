import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Length, Matches } from 'class-validator';

export abstract class LoginEmployeeDto {
  @ApiProperty({ default: '0962535253' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @Matches(/^09[345689]\d{7}$/)
  readonly phone: string;

  @ApiProperty({ default: 'test1234' })
  @IsString()
  @Length(6, 16)
  readonly password: string;
}
