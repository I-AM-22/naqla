import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsUUID } from 'class-validator';

export class JoinChatDto {
  @ApiProperty()
  @IsNotEmpty()
  @IsUUID('all')
  subOrderId: string;
}
