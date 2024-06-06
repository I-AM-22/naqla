import { IRole } from '@models/roles/interfaces/role.interface';

export interface IPerson {
  id: string;
  phone: string;
  role: IRole;
}
