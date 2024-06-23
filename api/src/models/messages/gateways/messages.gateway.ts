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
import { Logger, Inject, UseGuards } from '@nestjs/common';
import { Socket, Server } from 'socket.io';
import { CreateMessageDto } from '../dto/create-message.dto';
import { WsJwtGuard } from '@common/guards';
import { IPerson } from '@common/interfaces';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISubOrderRepository } from '@models/sub-orders/interfaces/repositories/sub-order.repository.interface';

@UseGuards(WsJwtGuard)
@WebSocketGateway()
export class MessageGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer() server: Server;

  private logger: Logger = new Logger('MessageGateway');

  constructor(
    @Inject(SUB_ORDER_TYPES.repository.subOrder)
    private readonly subOrderRepository: ISubOrderRepository,
  ) {}

  @SubscribeMessage('setup')
  handleSetup(
    @ConnectedSocket() client: Socket,
    @MessageBody() userData: IPerson,
  ) {
    client.join(userData.id);
    client.emit('connected');
  }

  @SubscribeMessage('join chat')
  async handleJoinChat(
    @ConnectedSocket() client: Socket,
    data: { subOrderId: string; userId: string; isUser: boolean },
  ) {
    if (!data.subOrderId || typeof data.isUser !== 'boolean' || !data.userId) {
      client.emit('error', {
        type: 'socket',
        message: 'please provide subOrderId and isUser and userId',
      });
      return;
    }
    const subOrder = await this.subOrderRepository.findByIdForMessage(
      data.subOrderId,
    );
    if (!subOrder) {
      client.to(data.userId).emit('error', {
        type: 'socket',
        message: 'subOrder not found',
      });
      return;
    }
    if (
      (!data.isUser && subOrder.car.driver.id !== data.userId) ||
      (data.isUser && subOrder.order.user.id !== data.userId)
    ) {
      client.to(data.userId).emit('error', {
        type: 'socket',
        message: 'Can not join this chat',
      });
    }
    client.join(data.subOrderId);
    client.emit('joined');
  }

  @SubscribeMessage('new-message')
  async handleMessage(
    @MessageBody()
    message: CreateMessageDto,
    @ConnectedSocket() client: Socket,
  ): Promise<void> {
    if (!message.content || !message.isUser || !message.subOrderId) {
      client.emit('error', {
        type: 'socket',
        message: 'please provide content and isUser and subOrderId',
      });
      return;
    }
    client.to(message.subOrderId).emit('message-received', message);
  }

  afterInit(server: Server) {
    this.logger.log('Init');
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  handleConnection(client: Socket, ...args: any[]) {
    this.logger.log(`Client connected: ${client.id}`);
  }
}
