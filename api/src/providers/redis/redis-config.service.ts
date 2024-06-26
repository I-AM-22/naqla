import { RedisModuleOptions, RedisOptionsFactory } from '@liaoliaots/nestjs-redis';
import { Inject, Injectable } from '@nestjs/common';
import MailConfig from '@config/mail/mail.config';
import { ConfigType } from '@nestjs/config';

@Injectable()
export class RedisConfigService implements RedisOptionsFactory {
  constructor(@Inject(MailConfig.KEY) private redisOptions: ConfigType<typeof MailConfig>) {}
  createRedisOptions(): RedisModuleOptions | Promise<RedisModuleOptions> {
    return {
      config: {
        port: this.redisOptions.queue_port,
        host: this.redisOptions.queue_host,
      },
    };
  }
}
