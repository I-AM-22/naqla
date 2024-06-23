import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsString, IsUUID } from 'class-validator';

export class CreateMessageDto {
  @ApiProperty()
  @IsString()
  content: string;

  @ApiProperty()
  @IsBoolean()
  isUser: boolean;

  @ApiProperty()
  @IsUUID('all')
  subOrderId: string;
}
