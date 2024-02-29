import { Global, Module } from '@nestjs/common';
import { RedisStoreService } from './redis-store.service';
import { RedisModule } from '@liaoliaots/nestjs-redis';
import { ConfigModule } from '@nestjs/config';
import MailConfig from '../../config/mail/mail.config';
import { RedisConfigService } from '../../providers/redis';

@Global()
@Module({
  imports: [
    RedisModule.forRootAsync({
      useClass: RedisConfigService,
      imports: [ConfigModule.forFeature(MailConfig)],
    }),
  ],
  providers: [RedisStoreService],
  exports: [RedisStoreService],
})
export class RedisStoreModule {}
