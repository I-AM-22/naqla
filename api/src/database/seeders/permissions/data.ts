import { Action, Entities, ROLE } from '@common/enums';
import { IPermission } from '@models/permissions/interfaces';

type pp = { roles?: any[] } & IPermission;
export const permissions: pp[] = [
  {
    action: Action.Manage,
    subject: Entities.User,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.City,
    roles: [ROLE.USER, ROLE.EMPLOYEE, ROLE.ADMIN, ROLE.DRIVER],
  },
  {
    action: Action.Manage,
    subject: Entities.City,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.User,
    roles: [ROLE.USER, ROLE.EMPLOYEE, ROLE.ADMIN, ROLE.DRIVER],
  },
  {
    action: Action.Manage,
    subject: Entities.Employee,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Statistics,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Wallet,
    roles: [ROLE.ADMIN, ROLE.EMPLOYEE],
  },
  {
    action: Action.Read,
    subject: Entities.Admin,
    roles: [ROLE.ADMIN],
  },
  { action: Action.Manage, subject: Entities.All, roles: [ROLE.SUPER_ADMIN] },
  {
    action: Action.Create,
    subject: Entities.Order,
    roles: [ROLE.USER],
  },
  {
    action: Action.Delete,
    subject: Entities.Order,
    roles: [ROLE.ADMIN, ROLE.USER],
  },
  {
    action: Action.Manage,
    subject: Entities.Suborder,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Create,
    subject: Entities.Suborder,
    roles: [ROLE.EMPLOYEE, ROLE.ADMIN],
  },
  {
    action: Action.Delete,
    subject: Entities.Suborder,
    roles: [ROLE.EMPLOYEE, ROLE.ADMIN],
  },
  {
    action: Action.Create,
    subject: Entities.Role,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Update,
    subject: Entities.Role,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Delete,
    subject: Entities.Role,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Permission,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Message,
    roles: [ROLE.USER, ROLE.DRIVER, ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.Payment,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Driver,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Car,
    roles: [ROLE.ADMIN, ROLE.DRIVER],
  },
  {
    action: Action.Read,
    subject: Entities.Profit,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Create,
    subject: Entities.Advantage,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.Advantage,
    roles: [ROLE.ADMIN, ROLE.USER, ROLE.DRIVER, ROLE.EMPLOYEE],
  },
  ,
  {
    action: Action.Delete,
    subject: Entities.Advantage,
    roles: [ROLE.ADMIN],
  },
];
