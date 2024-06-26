import { Injectable, Logger } from '@nestjs/common';
import { Cron, CronExpression } from '@nestjs/schedule';
import { PhotoCleanupService } from './photo-cleanup.service';

@Injectable()
export class PhotoCleanupScheduler {
  constructor(private readonly imageCleanupService: PhotoCleanupService) {}

  @Cron(CronExpression.EVERY_DAY_AT_MIDNIGHT)
  async handleFileCleanup() {
    try {
      await this.imageCleanupService.deletePhotosOlderThanDays();
      Logger.log(`Photo cleanup completed for 1 days.`, 'PhotoCleanupService');
    } catch (error) {
      Logger.error(`Error occurred during file cleanup: ${error}`, 'PhotoCleanupService');
    }
  }
}
