import { CanActivate, ExecutionContext, ForbiddenException, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Observable } from 'rxjs';
import { denied_error } from '../constants';
import { ROLE } from '@common/enums';

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private reflector: Reflector) {}
  canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
    const requiredRoles = this.reflector.getAllAndOverride<string[]>('roles', [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!requiredRoles) return true;
    const { user }: { user: any } = context.switchToHttp().getRequest();
    if (user.role.name === ROLE.SUPER_ADMIN) return true;
    if (!requiredRoles.includes(user.role.name)) throw new ForbiddenException(denied_error);
    else return true;
  }
}
