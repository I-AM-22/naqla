import { JwtService } from '@nestjs/jwt';
import { Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import { JwtConfig } from '../../config/app';
import { RedisStoreService } from '../redis-store/redis-store.service';

@Injectable()
export class JwtTokenService {
  constructor(
    private jwt: JwtService,
    @Inject(JwtConfig.KEY)
    private readonly jwtConfig: ConfigType<typeof JwtConfig>,
    private readonly redisStoreService: RedisStoreService,
  ) {}
  async signToken(id: string, entity: string): Promise<string> {
    const payload = { sub: id, entity };
    const token = await this.jwt.signAsync(payload, {
      secret: this.jwtConfig.jwt_secret,
      expiresIn: this.jwtConfig.jwt_expires_in + 'd',
    });
    await this.redisStoreService.storeToken(token);
    await this.redisStoreService.storeUserId(id);
    return token;
  }
}
