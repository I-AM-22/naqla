import { User } from '@models/users/entities/user.entity';
import { ApiProperty } from '@nestjs/swagger';

export class StaticsUser extends User {
  @ApiProperty()
  countOrderDelivered: number;
  @ApiProperty()
  active: boolean;
}
