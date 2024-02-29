import { Module } from '@nestjs/common';
import { MailProcessor } from './mail.processor';
import { MailerModule } from '@nestjs-modules/mailer';
import { BullModule } from '@nestjs/bull';
import { MailService } from './mail.service';
import { ConfigModule } from '@nestjs/config';
import { QUEUE_NAME } from '../../common/constants';
import { AppConfig } from '../../config/app';
import MailConfig from '../../config/mail/mail.config';
import { BullService } from '../../providers/bull';
import { MailerOptionService } from '../../providers/mailer';

@Module({
  imports: [
    MailerModule.forRootAsync({
      imports: [ConfigModule.forFeature(MailConfig)],
      useClass: MailerOptionService,
    }),
    BullModule.registerQueue({ name: QUEUE_NAME }),
    BullModule.forRootAsync({
      imports: [ConfigModule.forFeature(MailConfig)],
      useClass: BullService,
    }),
    ConfigModule.forFeature(AppConfig),
    ConfigModule.forFeature(MailConfig),
  ],
  providers: [MailService, MailProcessor],
  exports: [MailService],
})
export class MailModule {}
