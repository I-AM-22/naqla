import { InjectRedis, DEFAULT_REDIS_NAMESPACE } from '@liaoliaots/nestjs-redis';
import { Injectable } from '@nestjs/common';
import Redis from 'ioredis';
import { user_key, token_key } from '../../common/constants';
import { ConfigService } from '@nestjs/config';
import { User } from 'src/models/users';

@Injectable()
export class RedisStoreService {
  constructor(
    private readonly configService: ConfigService,
    @InjectRedis(DEFAULT_REDIS_NAMESPACE) private readonly redis: Redis,
  ) {}
  async storeUserId(id: string) {
    const redisExpire =
      parseInt(this.configService.get('JWT_EXPIRES_IN')) * 24 * 3600;
    return this.redis.set(user_key, id, 'EX', redisExpire);
  }

  async getStoredUserId() {
    return this.redis.get(user_key);
  }

  async storeToken(token: string) {
    const redisExpire =
      parseInt(this.configService.get('JWT_EXPIRES_IN')) * 24 * 3600;
    return this.redis.set(token_key, token, 'EX', redisExpire);
  }

  async getStoredToken() {
    return this.redis.get(token_key);
  }

  async storeNonConfirmed(user: User) {
    const redisExpire = 24 * 3600;
    const otp = '1234';
    return this.redis.set(otp, JSON.stringify(user), 'EX', redisExpire);
  }

  async getNonConfirmed(otp: string): Promise<User> {
    const user: User = JSON.parse(await this.redis.get(otp));
    return user;
  }
}
