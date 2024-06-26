import { Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtPayload } from '../interfaces';
import { IAuthUserService } from '../interfaces/services/auth.service.interface';
import { AUTH_TYPES } from '../interfaces/type';
import { Entities } from '@common/enums';
import { strategies } from '@common/constants/jwt.constant';

@Injectable()
export class JwtUserStrategy extends PassportStrategy(Strategy, strategies.user) {
  constructor(
    config: ConfigService,
    @Inject(AUTH_TYPES.service) private authUserService: IAuthUserService,
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
