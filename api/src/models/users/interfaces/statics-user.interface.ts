import { ApiProperty } from '@nestjs/swagger';
import { User } from '../entities/user.entity';

export class StaticsUser extends User {
  @ApiProperty()
  countOrderDelivered: number;
  @ApiProperty()
  active: boolean;
}
