import { ApiProperty } from '@nestjs/swagger';
import { User } from '../../models/users';

export abstract class AuthUserResponse {
  @ApiProperty()
  token: string;

  @ApiProperty({ type: User })
  user: User;
}
