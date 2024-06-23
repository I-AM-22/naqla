import {
  Controller,
  Get,
  Param,
  Post,
  Body,
  Delete,
  Inject,
  Patch,
  UseInterceptors,
} from '@nestjs/common';
import { Message } from '../entities/message.entity';
import { IMessagesService } from '../interfaces/services/messages.service.interface';
import { MESSAGE_TYPES } from '../interfaces/type';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';
import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiTags,
} from '@nestjs/swagger';
import { PaginatedResponse } from '@common/types';
import { bad_req, denied_error, data_not_found } from '@common/constants';
import { Auth, GetUser } from '@common/decorators';
import { LoggingInterceptor } from '@common/interceptors';
import { IPerson } from '@common/interfaces';

@ApiTags('Messages')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'messages', version: '1' })
export class MessagesController {
  constructor(
    @Inject(MESSAGE_TYPES.service)
    private readonly messagesService: IMessagesService,
  ) {}

  @ApiOkResponse({ type: PaginatedResponse<Message> })
  @Get(':subOrderId')
  async find(
    @Param('subOrderId') subOrderId: string,
    @GetUser() person: IPerson,
  ): Promise<Message[]> {
    return this.messagesService.find(subOrderId, person);
  }

  @ApiOkResponse({ type: Message })
  @Get(':id')
  async findOne(@Param('id') id: string): Promise<Message> {
    return this.messagesService.findOne(id);
  }

  @ApiCreatedResponse({ type: Message })
  @Post()
  async create(
    @Body() createMessageDto: CreateMessageDto,
    @GetUser() person: IPerson,
  ): Promise<Message> {
    return this.messagesService.create(createMessageDto, person);
  }

  @ApiOkResponse({ type: Message })
  @Patch(':id')
  async update(
    @Param('id') id: string,
    @Body() updateMessageDto: UpdateMessageDto,
  ): Promise<Message> {
    return this.messagesService.update(id, updateMessageDto);
  }

  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Param('id') id: string): Promise<void> {
    return this.messagesService.delete(id);
  }
}
