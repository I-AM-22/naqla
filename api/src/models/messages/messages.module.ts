import { Module, Provider } from '@nestjs/common';
import { MessagesService } from './services/messages.service';
import { MESSAGE_TYPES } from './interfaces/type';
import { MessageRepository } from './repositories/message.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Message } from './entities/message.entity';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';
import { MessageGateway } from './gateways/messages.gateway';
import { ConfigModule } from '@nestjs/config';
import { JwtConfig } from '@config/app';
import { MessagesController } from './controllers/messages.controller';
import { SubOrdersMessagesController } from './controllers/sub-orders-messages.controller';
import { UsersModule } from '@models/users/users.module';
import { DriversModule } from '@models/drivers/drivers.module';
import { WebSocketDocsController } from './controllers/websocket.controller';

export const MessageRepositoryProvider: Provider = {
  provide: MESSAGE_TYPES.repository,
  useClass: MessageRepository,
};

@Module({
  imports: [
    SubOrdersModule,
    UsersModule,
    DriversModule,
    TypeOrmModule.forFeature([Message]),
    ConfigModule.forFeature(JwtConfig),
  ],
  controllers: [MessagesController, SubOrdersMessagesController, WebSocketDocsController],
  providers: [MessageRepositoryProvider, MessagesService, MessageGateway],
})
export class MessagesModule {}
