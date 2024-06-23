import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Message } from '../entities/message.entity';
import { IMessageRepository } from '../interfaces/repositories/message.repository.interface';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';

@Injectable()
export class MessageRepository implements IMessageRepository {
  constructor(
    @InjectRepository(Message)
    private readonly messageRepository: Repository<Message>,
  ) {}

  async findAll(subOrderId: string): Promise<Message[]> {
    return await this.messageRepository.find({ where: { subOrderId } });
  }

  async findById(id: string): Promise<Message> {
    return await this.messageRepository.findOne({ where: { id } });
  }

  async create(dto: CreateMessageDto): Promise<Message> {
    const newMessage = this.messageRepository.create(dto);
    return await this.messageRepository.save(newMessage);
  }

  async update(message: Message, dto: UpdateMessageDto): Promise<Message> {
    message.content = dto.content;
    await this.messageRepository.save(message);
    return this.findById(message.id);
  }

  async delete(message: Message): Promise<void> {
    await this.messageRepository.softRemove(message);
  }
}
