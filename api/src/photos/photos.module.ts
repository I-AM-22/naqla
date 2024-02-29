import { Module } from '@nestjs/common';
import { PhotosController } from './photos.controller';
import { MulterModule } from '@nestjs/platform-express';
import { PhotosService } from './photos.service';
import { MulterService } from '../providers/multer';

@Module({
  imports: [MulterModule.registerAsync({ useClass: MulterService })],
  controllers: [PhotosController],
  providers: [PhotosService],
})
export class PhotosModule {}
