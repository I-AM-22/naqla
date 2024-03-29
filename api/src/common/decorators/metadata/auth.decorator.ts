import { UseGuards, applyDecorators } from '@nestjs/common';
import { CaslAbilitiesGuard, JwtGuard, RolesGuard } from '../../guards';
import { ApiBearerAuth, ApiUnauthorizedResponse } from '@nestjs/swagger';

export function Auth() {
  return applyDecorators(
    UseGuards(JwtGuard, RolesGuard, CaslAbilitiesGuard),
    ApiBearerAuth('token'),
    ApiUnauthorizedResponse({ description: 'Unauthorized' }),
  );
}
