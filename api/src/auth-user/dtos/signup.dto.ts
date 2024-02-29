import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsString, Length, Matches } from 'class-validator';

export abstract class SignUpDto {
  @ApiProperty({ default: '0962535253' })
  @IsNotEmpty({ message: 'please provide phone number' })
  @Matches(/^09\d{8}$/)
  readonly phone: string;

  @ApiProperty({ default: 'bahaa Alden' })
  @IsString()
  @Length(3, 16)
  readonly firstName: string;

  @ApiProperty({ default: 'Abdo' })
  @IsString()
  @Length(3, 16)
  readonly lastName: string;

  @ApiProperty({ default: 'test1234' })
  @IsString()
  @Length(6, 16)
  readonly password: string;
}
