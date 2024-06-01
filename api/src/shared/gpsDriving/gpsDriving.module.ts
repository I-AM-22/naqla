import { Global, Module } from '@nestjs/common';
import { GpsDrivingService } from './gpsDriving.service';

@Global()
@Module({
  providers: [GpsDrivingService],
  exports: [GpsDrivingService],
})
export class GpsDrivingModule {}
