import { SetMetadata } from '@nestjs/common';
import { ROLE } from '../../enums';

export const Roles = (...roles: ROLE[]) => SetMetadata('roles', roles);
