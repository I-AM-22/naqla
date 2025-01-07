import { Injectable, ExecutionContext, Inject, CanActivate, UnauthorizedException } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { IS_PUBLIC_KEY } from '../decorators';
import { JwtService } from '@nestjs/jwt';
import { JwtConfig } from '@config/app';
import { ConfigType } from '@nestjs/config';
import { jwtPayload } from '@app/auth-user';
import { ISocketWithUser } from '@common/interfaces/socket-user.interface';
import { Entities } from '@common/enums';
import { IPerson } from '@common/interfaces';
import { DriversService } from '@models/drivers/services/drivers.service';
import { UsersService } from '@models/users/services/users.service';

@Injectable()
export class WsJwtGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    @Inject(JwtConfig.KEY)
    private readonly jwtConfig: ConfigType<typeof JwtConfig>,
    private jwt: JwtService,
    private usersService: UsersService,
    private driversService: DriversService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
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
      throw new UnauthorizedException('There is no token');
    }

    try {
      const decode = await this.jwt.verifyAsync<jwtPayload>(token, {
        secret: this.jwtConfig.jwt_secret,
      });
      if (decode.entity === Entities.User) {
        client.user = (await this.usersService.findOne(decode.sub)) as IPerson;
        return true;
      } else if (decode.entity === Entities.Driver) {
        client.user = (await this.driversService.findOne(decode.sub)) as IPerson;
        return true;
      }
      throw new UnauthorizedException('The user not here');
    } catch (err) {
      throw new UnauthorizedException('Invalid token');
    }
  }
}
