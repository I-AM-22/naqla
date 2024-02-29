import {
  AbilityBuilder,
  ExtractSubjectType,
  createMongoAbility,
} from '@casl/ability';
import { Injectable } from '@nestjs/common';
import { User } from '../../models/users';
import { AppAbility, Subjects } from './casl.interface';

@Injectable()
export class CaslAbilityFactory {
  defineAbility(currentUser: User) {
    const { can, build, cannot } = new AbilityBuilder<AppAbility>(
      createMongoAbility,
    );
    currentUser.role.permissions.forEach((p) => {
      can(p.action, p.subject);
    });

    return build({
      detectSubjectType: (item) =>
        item.constructor as ExtractSubjectType<Subjects>,
    });
  }
}
