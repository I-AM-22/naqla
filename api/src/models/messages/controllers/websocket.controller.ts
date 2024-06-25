import { Controller, Post, Body } from '@nestjs/common';
import { ApiTags, ApiBody } from '@nestjs/swagger';
import { SocketMessageDto } from '../dto/socket.message.dto';
import { JoinChatDto } from '../dto/join-chat.dto';
import { Auth } from '@common/decorators';
import { ApiWebSocketEvent } from '@common/decorators/swagger/websocket.swagger';
import { SuccessDto } from '../dto/success.dto';

@ApiTags('Websocket')
@Auth()
@Controller('websocket')
export class WebSocketDocsController {
  @ApiWebSocketEvent(
    'setup',
    'Setup the user main room',
    'connected',
    SuccessDto,
  )
  @Post('setup')
  setup() {
    return { message: 'WebSocket setup endpoint for Swagger documentation' };
  }

  @ApiWebSocketEvent(
    'join-chat',
    'Join the chat room',
    'joined',
    SuccessDto,
    JoinChatDto,
  )
  @Post('join-chat')
  joinChat(@Body() dto: JoinChatDto) {
    return {
      message: `Join chat room ${dto.subOrderId} endpoint for Swagger documentation`,
    };
  }

  @ApiWebSocketEvent(
    'new-message',
    'Pass the new message to the users in the same chat',
    'message-received',
    SocketMessageDto,
    SocketMessageDto,
  )
  @Post('new-message')
  @ApiBody({ type: SocketMessageDto })
  newMessage(@Body() dto: SocketMessageDto) {
    return { message: 'Send new message endpoint for Swagger documentation' };
  }
}
