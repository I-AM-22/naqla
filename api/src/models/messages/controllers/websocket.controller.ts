import { Controller, Post } from '@nestjs/common';
import { ApiTags, ApiBody, ApiOkResponse } from '@nestjs/swagger';
import { SocketMessageDto } from '../dto/socket.message.dto';
import { JoinChatDto } from '../dto/join-chat.dto';
import { ApiWebSocketEvent, Auth } from '@common/decorators';
import { SuccessDto } from '../dto/success.dto';
import { CustomValidationError } from '@common/types';

@ApiTags('Websocket')
@Auth()
@Controller('websocket')
export class WebSocketDocsController {
  @ApiWebSocketEvent('setup', 'Setup the user main room', 'connected', SuccessDto)
  @Post('setup')
  setup() {
    return { message: 'WebSocket setup endpoint for Swagger documentation' };
  }

  @ApiWebSocketEvent('join-chat', 'Join the chat room', 'joined', SuccessDto, JoinChatDto)
  @Post('join-chat')
  joinChat() {
    return {
      message: `Join chat room endpoint for Swagger documentation`,
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
  newMessage() {
    return { message: 'Send new message endpoint for Swagger documentation' };
  }

  @ApiOkResponse({
    type: CustomValidationError,
    description: `Event: "error" will be emitted`,
  })
  @Post('error')
  error() {
    return { message: 'Send new message endpoint for Swagger documentation' };
  }
}
