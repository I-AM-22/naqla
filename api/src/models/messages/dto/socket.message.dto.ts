import { ApiProperty } from '@nestjs/swagger';

export class SocketMessageDto {
  @ApiProperty()
  content: string;

  @ApiProperty()
  isUser: boolean;

  @ApiProperty()
  subOrderId: string;

  @ApiProperty()
  createdAt: Date;

  @ApiProperty()
  updatedAt: Date;
}
