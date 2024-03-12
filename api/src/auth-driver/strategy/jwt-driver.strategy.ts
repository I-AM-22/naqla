import { Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtPayload } from '../interfaces';
import { AUTH_DRIVER_TYPES } from '../interfaces/type';
import { IAuthDriverService } from '../interfaces/services/auth.service.interface';
import { Entities } from '../../common/enums';

@Injectable()
export class JwtDriverStrategy extends PassportStrategy(
  Strategy,
  'jwt-driver',
) {
  constructor(
    config: ConfigService,
    @Inject(AUTH_DRIVER_TYPES.service)
    private authUserService: IAuthDriverService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }
  async validate(payload: jwtPayload) {
    if (payload.entity !== Entities.Driver) return;

    const driver = this.authUserService.validate(payload);

    return driver;
  }
}
