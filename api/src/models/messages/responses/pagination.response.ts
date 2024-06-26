import { PaginatedResponse } from '@common/types';
import { ApiProperty } from '@nestjs/swagger';
import { Message } from '../entities/message.entity';

export class PaginatedMessageResponse extends PaginatedResponse<Message> {
  @ApiProperty({ type: Message, isArray: true })
  data: Message[];
}
