import { BullRootModuleOptions, SharedBullConfigurationFactory } from '@nestjs/bull';
import { ConfigType } from '@nestjs/config';
import MailConfig from '@config/mail/mail.config';
import { Inject } from '@nestjs/common';

export class BullService implements SharedBullConfigurationFactory {
  constructor(
    @Inject(MailConfig.KEY)
    private readonly queueConfig: ConfigType<typeof MailConfig>,
  ) {}
  createSharedConfiguration(): BullRootModuleOptions | Promise<BullRootModuleOptions> {
    return {
      redis: {
        host: this.queueConfig.queue_host,
        port: this.queueConfig.queue_port,
      },
    };
  }
}
