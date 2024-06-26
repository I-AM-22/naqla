import { PaginatedResponse } from '@common/types';
import { ApiProperty } from '@nestjs/swagger';
import { User } from '../entities/user.entity';

export class PaginatedUserResponse extends PaginatedResponse<User> {
  @ApiProperty({ type: User, isArray: true })
  data: User[];
}
