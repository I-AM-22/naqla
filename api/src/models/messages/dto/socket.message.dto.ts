import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsDateString, IsNotEmpty, IsString, IsUUID } from 'class-validator';

export class SocketMessageDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsUUID('all')
  id: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  content: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsBoolean()
  isUser: boolean;

  @ApiProperty()
  @IsNotEmpty()
  @IsUUID('all')
  subOrderId: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsDateString()
  createdAt: Date;

  @ApiProperty()
  @IsNotEmpty()
  @IsDateString()
  updatedAt: Date;
}
