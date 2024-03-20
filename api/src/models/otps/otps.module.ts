import { Module } from '@nestjs/common';
import { OtpsService } from './services/otps.service';
import { OtpRepository } from './repositories/otp.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Otp } from './entities/otp.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Otp])],
  controllers: [],
  providers: [OtpsService, OtpRepository],
  exports: [OtpsService, OtpRepository],
})
export class OtpsModule {}
