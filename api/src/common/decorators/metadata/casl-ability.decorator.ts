import { SetMetadata } from '@nestjs/common';
import { RequiredRole } from '../../../shared/casl';

export const CHECK_ABILITY = 'check_ability';

export const CheckAbilities = (...requirements: RequiredRole[]) => SetMetadata(CHECK_ABILITY, requirements);
