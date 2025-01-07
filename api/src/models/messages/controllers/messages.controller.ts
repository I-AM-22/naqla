import { Controller, Get, Param, Post, Body, Delete, Patch, UseInterceptors, Query } from '@nestjs/common';
import { Message } from '../entities/message.entity';
import { CreateMessageDto } from '../dto/create-message.dto';
import { UpdateMessageDto } from '../dto/update-message.dto';
import { ApiCreatedResponse, ApiNoContentResponse, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, GetUser, Roles } from '@common/decorators';
import { LoggingInterceptor } from '@common/interceptors';
import { IPerson } from '@common/interfaces';
import { ROLE } from '@common/enums';
import { PaginatedMessageResponse } from '../responses/pagination.response';
import { MessagesService } from '../services/messages.service';

@ApiTags('Messages')
@ApiMainErrorsResponse()
@Auth()
@UseInterceptors(new LoggingInterceptor())
@Controller({ path: 'messages', version: '1' })
export class MessagesController {
  constructor(private readonly messagesService: MessagesService) {}

  @Roles(ROLE.ADMIN)
  @ApiOkResponse({ type: PaginatedMessageResponse })
  @ApiQuery({
    name: 'page',
    allowEmptyValue: false,
    example: 1,
    required: false,
  })
  @ApiQuery({
    name: 'limit',
    allowEmptyValue: false,
    example: 10,
    required: false,
  })
  @Get()
  async find(@Query('page') page: number, @Query('limit') limit: number) {
    return this.messagesService.find(page, limit);
  }

  @ApiOkResponse({ type: Message })
  @Get(':id')
  async findOne(@Param('id') id: string): Promise<Message> {
    return this.messagesService.findOne(id);
  }

  @ApiCreatedResponse({ type: Message })
  @Post()
  async create(@Body() createMessageDto: CreateMessageDto, @GetUser() person: IPerson): Promise<Message> {
    return this.messagesService.create(createMessageDto, person);
  }

  @ApiOkResponse({ type: Message })
  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateMessageDto: UpdateMessageDto): Promise<Message> {
    return this.messagesService.update(id, updateMessageDto);
  }

  @ApiNoContentResponse()
  @Delete(':id')
  async delete(@Param('id') id: string): Promise<void> {
    return this.messagesService.delete(id);
  }
}
