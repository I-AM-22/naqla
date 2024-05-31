import { Global, Module } from '@nestjs/common';
import { GpsDrivinagService } from './gpsDrivinag.service';

@Global()
@Module({
  providers: [GpsDrivinagService],
  exports: [GpsDrivinagService],
})
export class GpsDrivinagModule {}
