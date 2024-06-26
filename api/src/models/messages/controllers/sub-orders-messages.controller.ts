import { ApiMainErrorsResponse, Auth, GetUser } from '@common/decorators';
import { LoggingInterceptor } from '@common/interceptors';
import { Controller, Get, Inject, Param, Query, UseInterceptors } from '@nestjs/common';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { MESSAGE_TYPES } from '../interfaces/type';
import { IMessagesService } from '../interfaces/services/messages.service.interface';
import { IPerson } from '@common/interfaces';
import { PaginatedMessageResponse } from '../responses/pagination.response';

@ApiTags('Messages')
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'suborders/:id/messages', version: '1' })
export class SubOrdersMessagesController {
  constructor(
    @Inject(MESSAGE_TYPES.service)
    private readonly messagesService: IMessagesService,
  ) {}

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
  async find(
    @Param('subOrderId') subOrderId: string,
    @Query('page') page: number,
    @Query('limit') limit: number,
    @GetUser() person: IPerson,
  ) {
    return this.messagesService.findForSubOrder(subOrderId, person, page, limit);
  }
}
