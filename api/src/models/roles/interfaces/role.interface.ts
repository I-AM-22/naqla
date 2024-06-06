import { ROLE } from '@common/enums';
import { IPermission } from '@models/permissions/interfaces/permission.interface';

export interface IRole {
  name: ROLE;
  permissions: IPermission[];
}
