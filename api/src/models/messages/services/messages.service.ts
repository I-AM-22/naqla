import { IMessageRepository } from '../interfaces/repositories/message.repository.interface';
import { MESSAGE_TYPES } from '../interfaces/type';
import { Injectable, Inject, NotFoundException, BadRequestException } from '@nestjs/common';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';
import { Message } from '../entities/message.entity';
import { item_not_found } from '@common/constants';
import { Entities, ROLE } from '@common/enums';
import { IPerson } from '@common/interfaces';
import { PaginatedResponse } from '@common/types';
import { SubOrdersService } from '@models/sub-orders/services/sub-orders.service';

@Injectable()
export class MessagesService {
  constructor(
    @Inject(MESSAGE_TYPES.repository)
    private readonly messageRepository: IMessageRepository,
    private readonly subOrdersService: SubOrdersService,
  ) {}

  async find(page: number, limit: number): Promise<PaginatedResponse<Message>> {
    return await this.messageRepository.findAll(page, limit);
  }

  async findForSubOrder(
    subOrderId: string,
    person: IPerson,
    page: number,
    limit: number,
  ): Promise<PaginatedResponse<Message>> {
    await this.subOrdersService.findByIdForMessage(subOrderId, person);

    return await this.messageRepository.findForSubOrder(subOrderId, page, limit);
  }

  async findOne(id: string): Promise<Message> {
    const message = await this.messageRepository.findById(id);
    if (!message) {
      throw new NotFoundException(item_not_found(Entities.Message));
    }
    return message;
  }

  async create(dto: CreateMessageDto, person: IPerson): Promise<Message> {
    if ((dto.isUser && person.role.name !== ROLE.USER) || (!dto.isUser && person.role.name !== ROLE.DRIVER)) {
      throw new BadRequestException(
        `When isUser is ${dto.isUser} the logged in user must be ${dto.isUser ? ROLE.USER : ROLE.DRIVER}`,
      );
    }
    await this.subOrdersService.findByIdForMessage(dto.subOrderId, person);

    return this.messageRepository.create(dto);
  }

  async update(id: string, dto: UpdateMessageDto): Promise<Message> {
    const message = await this.findOne(id);
    return this.messageRepository.update(message, dto);
  }

  async delete(id: string): Promise<void> {
    const message = await this.findOne(id);
    await this.messageRepository.delete(message);
  }
}
