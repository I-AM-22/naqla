import { Action, Entities, ROLE } from '../../../common/enums';
import { IPermission } from '../../../models/permissions';

type pp = { roles?: any[] } & IPermission;
export const permissions: pp[] = [
  {
    action: Action.Manage,
    subject: Entities.User,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.Category,
    roles: [ROLE.USER, ROLE.EMPLOYEE],
  },
  {
    action: Action.Read,
    subject: Entities.City,
    roles: [ROLE.USER, ROLE.EMPLOYEE],
  },
  {
    action: Action.Read,
    subject: Entities.Store,
    roles: [ROLE.USER, ROLE.EMPLOYEE],
  },
  {
    action: Action.Read,
    subject: Entities.User,
    roles: [ROLE.USER, ROLE.EMPLOYEE],
  },
  { action: Action.Manage, subject: Entities.Category, roles: [ROLE.ADMIN] },
  { action: Action.Manage, subject: Entities.Chat, roles: [ROLE.USER] },
  { action: Action.Manage, subject: Entities.City, roles: [ROLE.ADMIN] },
  { action: Action.Create, subject: Entities.Comment, roles: [ROLE.USER] },
  { action: Action.Update, subject: Entities.Comment, roles: [ROLE.USER] },
  { action: Action.Delete, subject: Entities.Comment, roles: [ROLE.USER] },
  {
    action: Action.Read,
    subject: Entities.Comment,
    roles: [ROLE.USER, ROLE.ADMIN],
  },
  { action: Action.Manage, subject: Entities.Comment, roles: [ROLE.USER] },
  { action: Action.Manage, subject: Entities.Coupon, roles: [ROLE.USER] },
  {
    action: Action.Read,
    subject: Entities.Delivery,
    roles: [ROLE.ADMIN, ROLE.EMPLOYEE],
  },
  {
    action: Action.Manage,
    subject: Entities.Employee,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Message,
    roles: [ROLE.USER],
  },
  {
    action: Action.Create,
    subject: Entities.Payment,
    roles: [ROLE.USER],
  },
  {
    action: Action.Delete,
    subject: Entities.Payment,
    roles: [ROLE.ADMIN, ROLE.EMPLOYEE],
  },
  {
    action: Action.Read,
    subject: Entities.Payment,
    roles: [ROLE.EMPLOYEE, ROLE.ADMIN],
  },
  {
    action: Action.Read,
    subject: Entities.Product,
    roles: [ROLE.USER, ROLE.ADMIN, ROLE.EMPLOYEE],
  },
  {
    action: Action.Create,
    subject: Entities.Product,
    roles: [ROLE.USER],
  },
  {
    action: Action.Delete,
    subject: Entities.Product,
    roles: [ROLE.USER],
  },
  {
    action: Action.Update,
    subject: Entities.Product,
    roles: [ROLE.USER],
  },
  {
    action: Action.Manage,
    subject: Entities.Profit,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Statistics,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Create,
    subject: Entities.Store,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Update,
    subject: Entities.Store,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Delete,
    subject: Entities.Store,
    roles: [ROLE.ADMIN],
  },
  {
    action: Action.Manage,
    subject: Entities.Wallet,
    roles: [ROLE.ADMIN, ROLE.EMPLOYEE],
  },
  { action: Action.Read, subject: Entities.Admin, roles: [ROLE.ADMIN] },
  { action: Action.Manage, subject: Entities.All, roles: [ROLE.SUPER_ADMIN] },
];
