import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtPayload } from '../interfaces';
import { Entities } from '@common/enums';
import { strategies } from '@common/constants/jwt.constant';
import { AuthUserService } from '../services/auth-user.service';

@Injectable()
export class JwtUserStrategy extends PassportStrategy(Strategy, strategies.user) {
  constructor(
    config: ConfigService,
    private authUserService: AuthUserService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }
  async validate(payload: jwtPayload) {
    if (payload.entity !== Entities.User) return;

    const user = this.authUserService.validate(payload);

    return user;
  }
}
