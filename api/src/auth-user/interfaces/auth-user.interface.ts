import { ApiProperty } from '@nestjs/swagger';
import { User } from '@models/users/entities/user.entity';

export abstract class AuthUserResponse {
  @ApiProperty()
  token: string;

  @ApiProperty({ type: User })
  user: User;
}
