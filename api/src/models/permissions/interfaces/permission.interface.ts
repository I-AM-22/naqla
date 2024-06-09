import { Action, Entities } from '@common/enums';

/**
 * Language variable type declaration.
 *
 * @interface
 */
export interface IPermission {
  action: Action;
  subject: Entities;
}
