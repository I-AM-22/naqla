import { CreateMessageDto } from './../../dto/create-message.dto';
import { UpdateMessageDto } from './../../dto/update-message.dto';
import { Message } from './../../entities/message.entity';
import { PaginatedResponse } from '@common/types';

export interface IMessageRepository {
  findAll(page: number, limit: number): Promise<PaginatedResponse<Message>>;

  findForSubOrder(subOrderId: string, page: number, limit: number): Promise<PaginatedResponse<Message>>;

  findById(id: string): Promise<Message>;
  create(createMessageDto: CreateMessageDto): Promise<Message>;
  update(message: Message, updateMessageDto: UpdateMessageDto): Promise<Message>;
  delete(message: Message): Promise<void>;
}
