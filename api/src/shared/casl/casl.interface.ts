import { InferSubjects, MongoAbility, MongoQuery } from '@casl/ability';
import { User } from '@models/users/entities/user.entity';
import { Action, Entities } from '@common/enums';
import { City } from '@models/cities/entities/city.entity';
import { Employee } from '@models/employees/entities/employee.entity';
import { Permission } from '@models/permissions/entities/permission.entity';
import { Role } from '@models/roles/entities/role.entity';
import { Admin } from '@models/admins/entities/admin.entity';
import { Driver } from '@models/drivers/entities/driver.entity';

export interface RequiredRole {
  action: Action;
  subject: Subjects;
}
export type Subjects =
  | InferSubjects<
      typeof Admin | typeof City | typeof Employee | typeof Permission | typeof Role | typeof User | typeof Driver
    >
  | Entities
  | 'all';
export type AppAbility = MongoAbility<[Action, Subjects], MongoQuery>;
