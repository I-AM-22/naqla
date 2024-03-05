import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Length, Matches } from 'class-validator';

export abstract class SignUpDto {
  @ApiProperty({ default: '0962535253' })
  @Length(10, 10, { message: 'Phone must contain 10 numbers' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Matches(/^09[345689]\d{7}$/)
  readonly phone: string;

  @ApiProperty({ default: 'bahaa Alden' })
  @IsString()
  @Length(3, 16)
  readonly firstName: string;

  @ApiProperty({ default: 'Abdo' })
  @IsString()
  @Length(3, 16)
  readonly lastName: string;
}
