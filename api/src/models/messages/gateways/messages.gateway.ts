import {
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
  OnGatewayInit,
  OnGatewayConnection,
  OnGatewayDisconnect,
  MessageBody,
  ConnectedSocket,
} from '@nestjs/websockets';
import {
  Logger,
  Inject,
  UseGuards,
  UseFilters,
  UsePipes,
} from '@nestjs/common';
import { Server } from 'socket.io';
import { WsJwtGuard } from '@common/guards';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISocketWithUser } from '@common/interfaces/socket-user.interface';
import { SocketMessageDto } from '../dto/socket.message.dto';
import { ISubOrdersService } from '@models/sub-orders/interfaces/services/sub-orders.service.interface';
import { WebsocketExceptionsFilter } from '@common/exceptions';
import { MainValidationPipe } from '@common/pipes';
import { JoinChatDto } from '../dto/join-chat.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Chat-event')
@UseGuards(WsJwtGuard)
@UseFilters(WebsocketExceptionsFilter)
@UsePipes(MainValidationPipe)
@WebSocketGateway({
  cors: {
    origin: 'http://localhost:3000',
    allowedHeaders: ['content-type', 'authorization'],
    credentials: true,
  },
})
export class MessageGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer() server: Server;

  private logger: Logger = new Logger('MessageGateway');

  constructor(
    @Inject(SUB_ORDER_TYPES.service)
    private readonly subOrdersService: ISubOrdersService,
  ) {}

  @SubscribeMessage('setup')
  handleSetup(@ConnectedSocket() client: ISocketWithUser) {
    client.join(client.user.id);
    client.emit('connected', { status: 'success' });
  }

  @SubscribeMessage('join-chat')
  async handleJoinChat(
    @ConnectedSocket() client: ISocketWithUser,
    @MessageBody() dto: JoinChatDto,
  ) {
    await this.subOrdersService.findByIdForMessage(dto.subOrderId, client.user);

    client.join(dto.subOrderId);
    client.emit('joined', { status: 'success' });
    this.logger.log(`Client ${client.user.id} joined room ${dto.subOrderId}`);
  }

  @SubscribeMessage('new-message')
  async handleMessage(
    @MessageBody()
    message: SocketMessageDto,
    @ConnectedSocket() client: ISocketWithUser,
  ): Promise<void> {
    client.to(message.subOrderId).emit('message-received', message);
  }

  afterInit() {
    this.logger.log(`Init Server Gateway`);
  }

  handleDisconnect(client: ISocketWithUser) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  handleConnection(client: ISocketWithUser) {
    this.logger.log(`Client connected: ${client.id}`);
  }
}
