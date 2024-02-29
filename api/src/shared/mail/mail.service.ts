import { InjectQueue } from '@nestjs/bull';
import { Injectable } from '@nestjs/common';
import { Queue } from 'bull';
import { QUEUE_NAME } from '../../common/constants';
import { User } from '../../models/users';
import { LoggerService } from '../logger/logger.service';

@Injectable()
export class MailService {
  constructor(
    @InjectQueue(QUEUE_NAME)
    private mailQueue: Queue,
    private loggerService: LoggerService,
  ) {}

  /** Send email welcome link to new user account. */
  async sendWelcomeEmail(user: User, dynamicOrigin: string): Promise<boolean> {
    try {
      await this.mailQueue.add('welcome', {
        user,
        dynamicOrigin,
      });
      return true;
    } catch (error) {
      this.loggerService.error(
        this.constructor.name,
        `Error queueing welcome email to user ${user.phone}`,
      );
      return false;
    }
  }

  async sendPasswordReset(user: User, resetToken: string): Promise<boolean> {
    try {
      await this.mailQueue.add('passwordReset', {
        user,
        resetToken,
      });
      return true;
    } catch (error) {
      this.loggerService.error(
        this.constructor.name,

        `Error queueing passwordReset to user ${user.phone}`,
      );
      return false;
    }
  }

  async sendPasswordChanged(
    user: User,
    dynamicOrigin: string,
  ): Promise<boolean> {
    try {
      await this.mailQueue.add('passwordChanged', {
        user,
        dynamicOrigin,
      });
      return true;
    } catch (error) {
      this.loggerService.error(
        this.constructor.name,

        `Error queueing passwordChanged to user ${user.phone}`,
      );
      return false;
    }
  }
}
