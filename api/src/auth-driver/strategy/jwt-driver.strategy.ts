import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { jwtPayload } from '../interfaces';
import { Entities } from '@common/enums';
import { strategies } from '@common/constants/jwt.constant';
import { AuthDriverService } from '../services/auth-driver.service';

@Injectable()
export class JwtDriverStrategy extends PassportStrategy(Strategy, strategies.driver) {
  constructor(
    config: ConfigService,
    private authDriverService: AuthDriverService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }
  async validate(payload: jwtPayload) {
    if (payload.entity !== Entities.Driver) return;

    const driver = this.authDriverService.validate(payload);

    return driver;
  }
}
