import { MailerOptions, MailerOptionsFactory } from '@nestjs-modules/mailer';
import { Inject, Injectable } from '@nestjs/common';
import MailConfig from '@config/mail/mail.config';
import { ConfigType } from '@nestjs/config';
import { PugAdapter } from '@nestjs-modules/mailer/dist/adapters/pug.adapter';
import path = require('path');

@Injectable()
export class MailerOptionService implements MailerOptionsFactory {
  constructor(@Inject(MailConfig.KEY) private mailConfig: ConfigType<typeof MailConfig>) {}
  createMailerOptions(): MailerOptions | Promise<MailerOptions> {
    const mailerOptions: MailerOptions = {
      transport: {
        host: this.mailConfig.host,
        port: this.mailConfig.port,
        // secure: this.mailConfig.secure,
        // tls: { ciphers: 'SSLv3', }, // gmail
        auth: {
          user: this.mailConfig.user,
          pass: this.mailConfig.pass,
        },
      },
      defaults: {
        from: this.mailConfig.from,
      },
      template: {
        dir: path.join(__dirname, '..', '..', 'shared', 'mail/templates'),
        adapter: new PugAdapter(),
        options: {
          strict: true,
        },
      },
    };
    return mailerOptions;
  }
}
