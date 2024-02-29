// Import necessary modules and dependencies
import { MailerService } from '@nestjs-modules/mailer';
import {
  OnQueueActive,
  OnQueueCompleted,
  OnQueueFailed,
  Process,
  Processor,
} from '@nestjs/bull';
import { Inject } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { Job } from 'bull';
import { QUEUE_NAME, mailLive } from '../../common/constants';
import { AppConfig } from '../../config/app';
import MailConfig from '../../config/mail/mail.config';
import { User } from '../../models/users';
import { LoggerService } from '../logger/logger.service';

// Import utility functions and configurations

// Decorate the class as a processor for the specified queue
@Processor(QUEUE_NAME)
export class MailProcessor {
  private from: string;
  private appName: string;

  // Constructor to inject configuration and mailer service
  constructor(
    @Inject(AppConfig.KEY) private appConfig: ConfigType<typeof AppConfig>,
    @Inject(MailConfig.KEY) private mailConfig: ConfigType<typeof MailConfig>,
    private readonly mailerService: MailerService,
    private loggerService: LoggerService,
  ) {
    this.from = this.mailConfig.from;
    this.appName = this.appConfig.name;
  }

  // Logger instance for logging messages

  // Event handler for when a job in the queue becomes active
  @OnQueueActive()
  onActive(job: Job) {
    this.loggerService.debug(
      this.constructor.name,
      `Processing job ${job.id} of type ${job.name}. Data: ${JSON.stringify(
        job.data,
      )}`,
    );
  }

  // Event handler for when a job in the queue is completed
  @OnQueueCompleted()
  onComplete(job: Job, result: any) {
    this.loggerService.debug(
      this.constructor.name,

      `Completed job ${job.id} of type ${job.name}. Result: ${JSON.stringify(
        result,
      )}`,
    );
  }

  // Event handler for when a job in the queue fails
  @OnQueueFailed()
  onError(job: Job<any>, error: any) {
    this.loggerService.error(
      this.constructor.name,

      `Failed job ${job.id} of type ${job.name}: ${error.message}`,
      error.stack,
    );
  }

  // Process decorator for handling jobs of type 'welcome'
  @Process('welcome')
  async sendWelcomeEmail(
    job: Job<{ user: User; dynamicOrigin: string }>,
  ): Promise<any> {
    // Log the initiation of sending a welcome email
    this.loggerService.log(
      this.constructor.name,
      `Sending welcome email to '${job.data.user.phone}'`,
    );

    // Construct the URL for the email content
    const url = `${job.data.dynamicOrigin}`;

    // If in a live environment, return a mock confirmation message
    if (mailLive) {
      return 'SENT MOCK CONFIRMATION EMAIL';
    }

    try {
      // Send the welcome email using the mailer service
      const result = await this.mailerService.sendMail({
        template: 'welcome',
        context: {
          name: job.data.user.firstName,
          url,
          appName: this.appName,
        },
        subject: `Welcome to ${this.appConfig.name} Dear ${job.data.user.firstName}`,
        to: job.data.user.phone,
        from: this.from,
      });
      return result;
    } catch (error) {
      // Log an error if the email sending fails and propagate the error
      this.loggerService.error(
        this.constructor.name,

        `Failed to send welcome email to '${job.data.user.phone}'`,
        error.stack,
      );
      throw error;
    }
  }

  // Process decorator for handling jobs of type 'welcome'
  @Process('passwordReset')
  async sendPasswordReset(
    job: Job<{ user: User; resetToken: string }>,
  ): Promise<any> {
    // Log the initiation of sending a reset password email
    this.loggerService.log(
      this.constructor.name,
      `Sending password reset token to '${job.data.user.phone}'`,
    );

    // If in a live environment, return a mock confirmation message
    if (mailLive) {
      return 'SENT MOCK CONFIRMATION EMAIL';
    }

    try {
      // Send the reset password token using the mailer service
      const result = await this.mailerService.sendMail({
        template: 'passwordReset',
        context: {
          name: job.data.user.firstName,
          resetToken: job.data.resetToken,
        },
        subject: 'Your reset token valid for only 10 minute',
        to: job.data.user.phone,
        from: this.from,
      });
      return result;
    } catch (error) {
      // Log an error if the email sending fails and propagate the error
      this.loggerService.error(
        this.constructor.name,

        `Failed to send password reset token to '${job.data.user.phone}'`,
        error.stack,
      );
      throw error;
    }
  }

  @Process('passwordChanged')
  async sendPasswordChanged(
    job: Job<{ user: User; dynamicOrigin: string }>,
  ): Promise<any> {
    // Log the initiation of sending a password changed email
    this.loggerService.log(
      this.constructor.name,

      `Sending password changed message to '${job.data.user.phone}'`,
    );

    // If in a live environment, return a mock confirmation message
    if (mailLive) {
      return 'SENT MOCK CONFIRMATION EMAIL';
    }

    try {
      // Send the password changed message using the mailer service
      const result = await this.mailerService.sendMail({
        template: 'passwordChanged',
        context: {
          name: job.data.user.firstName,
          url: job.data.dynamicOrigin,
          appName: this.appName,
        },
        subject: 'Your password has been reset',
        to: job.data.user.phone,
        from: this.from,
      });
      return result;
    } catch (error) {
      // Log an error if the email sending fails and propagate the error
      this.loggerService.error(
        this.constructor.name,

        `Failed to send password changed message to '${job.data.user.phone}'`,
        error.stack,
      );
      throw error;
    }
  }
  // Additional methods for handling other types of jobs can be added here
  // ...
}
