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
import { Server } from 'socket.io';
import { WsJwtGuard } from '@common/guards';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ISubOrderRepository } from '@models/sub-orders/interfaces/repositories/sub-order.repository.interface';
import { ISocketWithUser } from '@common/interfaces/socket-user.interface';
import { SocketMessageDto } from '../dto/socket.message.dto';

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
  handleSetup(@ConnectedSocket() client: ISocketWithUser) {
    client.join(client.userId);
    client.emit('connected');
  }

  @SubscribeMessage('join-chat')
  async handleJoinChat(
    @ConnectedSocket() client: ISocketWithUser,
    @MessageBody()
    data: { subOrderId: string; isUser: boolean },
  ) {
    if (!data) {
      client.emit('error', {
        type: 'socket',
        message: 'please provide subOrderId and isUser',
      });
      return;
    }

    try {
      const subOrder = await this.subOrderRepository.findByIdForMessage(
        data.subOrderId,
        client.userId,
      );
      if (!subOrder) {
        client.to(client.userId).emit('error', {
          type: 'socket',
          message: 'subOrder not found',
        });
        return;
      }
      if (
        (!data.isUser && subOrder.car.driver.id !== client.userId) ||
        (data.isUser && subOrder.order.user.id !== client.userId)
      ) {
        client.emit('error', {
          type: 'socket',
          message: 'Can not join this chat',
        });
        return;
      }
    } catch (error) {
      client.emit('error', {
        type: 'socket',
        message: 'subOrder not found',
      });
      return;
    }

    client.join(data.subOrderId);
    client.emit('joined');
  }

  @SubscribeMessage('new-message')
  async handleMessage(
    @MessageBody()
    message: SocketMessageDto,
    @ConnectedSocket() client: ISocketWithUser,
  ): Promise<void> {
    if (
      !message.content ||
      !message.isUser ||
      !message.subOrderId ||
      !message.createdAt ||
      !message.updatedAt
    ) {
      client.emit('error', {
        type: 'socket',
        message:
          'please provide content and isUser and subOrderId and updatedAt and createdAt',
      });
      return;
    }

    client.to(message.subOrderId).emit('message-received', message);
  }

  afterInit(server: Server) {
    this.logger.log('Init');
  }

  handleDisconnect(client: ISocketWithUser) {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  handleConnection(client: ISocketWithUser, ...args: any[]) {
    this.logger.log(`Client connected: ${client.id}`);
  }
}
