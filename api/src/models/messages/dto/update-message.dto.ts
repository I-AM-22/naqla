import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString } from 'class-validator';

export class UpdateMessageDto {
  @ApiProperty()
  @IsString()
  @IsOptional()
  content: string;
}
