import { ApiProperty } from '@nestjs/swagger';
import { IsString, Length } from 'class-validator';

export class PasswordChangeDto {
  @ApiProperty({ default: 'test1234' })
  @IsString()
  @Length(6, 16)
  passwordCurrent: string;

  @ApiProperty({ default: 'test1235' })
  @IsString()
  @Length(6, 16)
  password: string;
}
