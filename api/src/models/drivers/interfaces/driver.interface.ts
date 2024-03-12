import { ROLE } from '../../../common/enums';

export type IDriver = {
  name: string;

  email: string;

  password: string;

  role?: ROLE.DRIVER;
};
