import { ApiProperty } from '@nestjs/swagger';

export const AUTH_TYPES = {
  service: 'IAuthService',
};

export class SendConfirm {
  @ApiProperty()
  message: string;
}
