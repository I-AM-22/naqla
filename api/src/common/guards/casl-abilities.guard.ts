import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Observable } from 'rxjs';
import { Reflector } from '@nestjs/core';
import { ForbiddenError } from '@casl/ability';
import { CaslAbilityFactory, RequiredRole } from '../../shared/casl';
import { CHECK_ABILITY } from '../decorators';
import { User } from '../../models/users';

@Injectable()
export class CaslAbilitiesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private caslAbilityFactory: CaslAbilityFactory,
  ) {}
  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const rules =
      this.reflector.getAllAndOverride<RequiredRole[]>(CHECK_ABILITY, [
        context.getHandler(),
        context.getClass(),
      ]) || [];
    const { user }: { user: User } = context.switchToHttp().getRequest();
    const ability = this.caslAbilityFactory.defineAbility(user);

    rules.forEach((rule) =>
      ForbiddenError.from(ability).throwUnlessCan(rule.action, rule.subject),
    );
    return true;
  }
}
