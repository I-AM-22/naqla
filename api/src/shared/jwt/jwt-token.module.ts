import { Global, Module } from '@nestjs/common';
import { JwtTokenService } from './jwt-token.service';
import { ConfigModule } from '@nestjs/config';
import { JwtConfig } from '@config/app';

@Global()
@Module({
  imports: [ConfigModule.forFeature(JwtConfig)],
  providers: [JwtTokenService],
  exports: [JwtTokenService],
})
export class JwtTokenModule {}
