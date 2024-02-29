import { Module } from '@nestjs/common';
import { DriverService } from './driver.service';
import { DriverController } from './driver.controller';

@Module({
  controllers: [DriverController],
  providers: [DriverService],
})
export class DriverModule {}
