import {
  AbilityBuilder,
  ExtractSubjectType,
  createMongoAbility,
} from '@casl/ability';
import { Injectable } from '@nestjs/common';
import { AppAbility, Subjects } from './casl.interface';
import { Role } from '../../models/roles';

@Injectable()
export class CaslAbilityFactory {
  defineAbility(currentUser: IUser) {
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
interface IUser {
  id: string;
  role: Role;
}
