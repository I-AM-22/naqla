import {
  Injectable,
  NestMiddleware,
  UnauthorizedException,
} from '@nestjs/common';
import { Request, Response } from 'express';
import { RedisStoreService } from '../../shared/redis-store';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  constructor(private readonly redisStoreService: RedisStoreService) {}
  async use(req: Request, res: Response, next: (error?: any) => void) {
    if (req.headers.authorization) {
      const token = req.headers.authorization.split(' ')[1];
      const storedToken = await this.redisStoreService.getStoredToken();
      if (token !== storedToken)
        throw new UnauthorizedException('Please login again!');
    }
    next();
  }
}
