import { AbilityBuilder, ExtractSubjectType, createMongoAbility } from '@casl/ability';
import { Injectable } from '@nestjs/common';
import { AppAbility, Subjects } from './casl.interface';
import { IPerson } from '@common/interfaces';

@Injectable()
export class CaslAbilityFactory {
  defineAbility(currentUser: IPerson) {
    const { can, build } = new AbilityBuilder<AppAbility>(createMongoAbility);
    currentUser.role.permissions.forEach((p) => {
      can(p.action, p.subject);
    });
    return build({
      detectSubjectType: (item) => item.constructor as ExtractSubjectType<Subjects>,
    });
  }
}
