import { Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

import { jwtPayload } from '../../../auth-user';
import { Entities } from '@common/enums';
import { strategies } from '@common/constants/jwt.constant';
import { ADMIN_TYPES } from '../interfaces/type';
import { IAdminsService } from '../interfaces/services/admins.service.interface';

@Injectable()
export class JwtAdminStrategy extends PassportStrategy(
  Strategy,
  strategies.admin,
) {
  constructor(
    config: ConfigService,
    @Inject(ADMIN_TYPES.service) private adminsService: IAdminsService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }
  async validate(payload: jwtPayload) {
    if (payload.entity !== Entities.Admin) return;

    const employee = await this.adminsService.validate(
      payload.sub,
      payload.iat,
    );

    return employee;
  }
}
