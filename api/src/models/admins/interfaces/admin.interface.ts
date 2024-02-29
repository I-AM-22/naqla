import { ROLE } from '../../../common/enums';

export type IAdmin = {
  name: string;

  email: string;

  password: string;

  role?: ROLE;
};
