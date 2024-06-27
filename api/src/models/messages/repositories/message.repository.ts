import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Message } from '../entities/message.entity';
import { IMessageRepository } from '../interfaces/repositories/message.repository.interface';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';
import { PaginatedResponse } from '@common/types';

@Injectable()
export class MessageRepository implements IMessageRepository {
  constructor(
    @InjectRepository(Message)
    private readonly messageRepository: Repository<Message>,
  ) {}

  async findAll(page: number, limit: number): Promise<PaginatedResponse<Message>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.messageRepository.find({
      skip,
      take,
      order: { createdAt: 'DESC' },
    });
    const totalDataCount = await this.messageRepository.count();
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async findForSubOrder(subOrderId: string, page: number, limit: number): Promise<PaginatedResponse<Message>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.messageRepository.find({
      where: { subOrderId },
      skip,
      take,
      order: { createdAt: 'DESC' },
    });
    const totalDataCount = await this.messageRepository.count({
      where: { subOrderId },
      order: { createdAt: 'DESC' },
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
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
