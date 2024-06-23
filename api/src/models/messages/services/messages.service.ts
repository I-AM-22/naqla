import { IMessageRepository } from '../interfaces/repositories/message.repository.interface';
import { MESSAGE_TYPES } from '../interfaces/type';
import { IMessagesService } from '../interfaces/services/messages.service.interface';
import { Injectable, Inject, NotFoundException } from '@nestjs/common';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';
import { Message } from '../entities/message.entity';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISubOrdersService } from '@models/sub-orders/interfaces/services/sub-orders.service.interface';
import { item_not_found } from '@common/constants';
import { Entities } from '@common/enums';
import { IPerson } from '@common/interfaces';

@Injectable()
export class MessagesService implements IMessagesService {
  constructor(
    @Inject(MESSAGE_TYPES.repository)
    private readonly messageRepository: IMessageRepository,
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
  ) {}

  async find(subOrderId: string, person: IPerson): Promise<Message[]> {
    const subOrder = await this.subOrdersService.findByIdForMessage(subOrderId);
    if (
      subOrder.car.driver.id !== person.id &&
      subOrder.order.user.id !== person.id
    ) {
      throw new NotFoundException(item_not_found(Entities.Suborder));
    }
    return await this.messageRepository.findAll(subOrderId);
  }

  async findOne(id: string): Promise<Message> {
    const message = await this.messageRepository.findById(id);
    if (!message) {
      throw new NotFoundException(item_not_found(Entities.Message));
    }
    return message;
  }

  async create(dto: CreateMessageDto, person: IPerson): Promise<Message> {
    const subOrder = await this.subOrdersService.findByIdForMessage(
      dto.subOrderId,
    );
    if (
      (!dto.isUser && subOrder.car.driver.id !== person.id) ||
      (dto.isUser && subOrder.order.user.id !== person.id)
    ) {
      throw new NotFoundException(item_not_found(Entities.Suborder));
    }
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
