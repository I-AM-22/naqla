import { ApiProperty } from '@nestjs/swagger';
import { BasePersonWithActive, BasePhoto } from '@common/base';

export class MiniUser extends BasePersonWithActive {
  @ApiProperty({ type: BasePhoto })
  photo: string;
}
