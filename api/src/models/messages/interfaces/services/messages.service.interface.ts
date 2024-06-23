import { IPerson } from '@common/interfaces';
import { CreateMessageDto } from './../../dto/create-message.dto';
import { UpdateMessageDto } from './../../dto/update-message.dto';
import { Message } from './../../entities/message.entity';

export interface IMessagesService {
  find(subOrderId: string, person: IPerson): Promise<Message[]>;

  findOne(id: string): Promise<Message>;

  create(createMessageDto: CreateMessageDto, person: IPerson): Promise<Message>;

  update(id: string, updateMessageDto: UpdateMessageDto): Promise<Message>;

  delete(id: string): Promise<void>;
}
