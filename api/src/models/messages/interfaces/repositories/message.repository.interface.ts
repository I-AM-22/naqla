import { CreateMessageDto } from './../../dto/create-message.dto';
import { UpdateMessageDto } from './../../dto/update-message.dto';
import { Message } from './../../entities/message.entity';

export interface IMessageRepository {
  findAll(subOrderId: string): Promise<Message[]>;
  findById(id: string): Promise<Message>;
  create(createMessageDto: CreateMessageDto): Promise<Message>;
  update(
    message: Message,
    updateMessageDto: UpdateMessageDto,
  ): Promise<Message>;
  delete(message: Message): Promise<void>;
}
