import { Module } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { PhotoCleanupService } from './photo-cleanup.service';
import { PhotoCleanupScheduler } from './photo-cleanup.scheduler';

@Module({
  imports: [ScheduleModule.forRoot()],
  providers: [PhotoCleanupService, PhotoCleanupScheduler],
})
export class PhotoCleanupModule {}
