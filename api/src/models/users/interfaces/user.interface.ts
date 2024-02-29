import { ROLE } from '../../../common/enums';

export type IUser = {
  name: string;

  email: string;

  password: string;

  role?: ROLE.USER;
};
