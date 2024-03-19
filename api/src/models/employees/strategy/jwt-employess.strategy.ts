import { Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';

import { IEmployeesService } from '../interfaces/services/employees.service.interface';
import { EMPLOYEE_TYPES } from '../interfaces/type';
import { jwtPayload } from '../../../auth-user';
import { Entities } from '../../../common/enums';
import { strategies } from '../../../common/constants/jwt.type';

@Injectable()
export class JwtEmployeeStrategy extends PassportStrategy(
  Strategy,
  strategies.employee,
) {
  constructor(
    config: ConfigService,
    @Inject(EMPLOYEE_TYPES.service) private employeesService: IEmployeesService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.get('JWT_SECRET'),
    });
  }
  async validate(payload: jwtPayload) {
    if (payload.entity !== Entities.Employee) return;

    const employee = await this.employeesService.validate(
      payload.sub,
      payload.iat,
    );

    return employee;
  }
}
