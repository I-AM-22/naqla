import { IPerson } from '@common/interfaces';
import { CreateMessageDto } from './../../dto/create-message.dto';
import { UpdateMessageDto } from './../../dto/update-message.dto';
import { Message } from './../../entities/message.entity';
import { PaginatedResponse } from '@common/types';

export interface IMessagesService {
  find(page: number, limit: number): Promise<PaginatedResponse<Message>>;

  findForSubOrder(
    subOrderId: string,
    person: IPerson,
    page: number,
    limit: number,
  ): Promise<PaginatedResponse<Message>>;

  findOne(id: string): Promise<Message>;

  create(createMessageDto: CreateMessageDto, person: IPerson): Promise<Message>;

  update(id: string, updateMessageDto: UpdateMessageDto): Promise<Message>;

  delete(id: string): Promise<void>;
}
