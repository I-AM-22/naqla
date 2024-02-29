import { InferSubjects, MongoAbility, MongoQuery } from '@casl/ability';
import { User } from '../../models/users';
import { Action, Entities } from '../../common/enums';
import { City } from '../../models/cities';
import { Employee } from '../../models/employees';
import { Permission } from '../../models/permissions';
import { Role } from '../../models/roles';
import { Admin } from '../../models/admins';

export interface RequiredRole {
  action: Action;
  subject: Subjects;
}
export type Subjects =
  | InferSubjects<
      | typeof Admin
      | typeof City
      | typeof Employee
      | typeof Permission
      | typeof Role
      | typeof User
    >
  | Entities
  | 'all';
export type AppAbility = MongoAbility<[Action, Subjects], MongoQuery>;
