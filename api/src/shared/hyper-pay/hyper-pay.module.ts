import { Global, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { HyperPayService } from './hyper-pay.service';
import hyperPayConfig from '@config/hyper-pay/hyper-pay.config';

@Global()
@Module({
  imports: [ConfigModule.forFeature(hyperPayConfig)],
  providers: [HyperPayService],
  exports: [HyperPayService],
})
export class HyperPayModule {}
