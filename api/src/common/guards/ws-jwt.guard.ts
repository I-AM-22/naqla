import {
  Injectable,
  ExecutionContext,
  Inject,
  CanActivate,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { IS_PUBLIC_KEY } from '../decorators';
import { JwtService } from '@nestjs/jwt';
import { JwtConfig } from '@config/app';
import { ConfigType } from '@nestjs/config';
import { jwtPayload } from '@app/auth-user';
import { ISocketWithUser } from '@common/interfaces/socket-user.interface';

@Injectable()
export class WsJwtGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    @Inject(JwtConfig.KEY)
    private readonly jwtConfig: ConfigType<typeof JwtConfig>,
    private jwt: JwtService,
  ) {}

  canActivate(context: ExecutionContext): boolean {
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);
    if (isPublic) {
      return true;
    }

    const client = context.switchToWs().getClient<ISocketWithUser>();
    const token = client.handshake.headers['authorization']?.split(' ')[1];

    if (!token) {
      client.emit('error', {
        type: 'socket',
        message: 'Unauthorized',
      });
      return;
    }

    try {
      const user = this.jwt.verify<jwtPayload>(token, {
        secret: this.jwtConfig.jwt_secret,
      });
      client.userId = user.sub;
      return true;
    } catch (err) {
      client.emit('error', {
        type: 'socket',
        message: 'Unauthorized',
      });
      return;
    }
  }
}
