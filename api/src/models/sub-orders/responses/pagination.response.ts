import { PaginatedResponse } from '@common/types';
import { ApiProperty } from '@nestjs/swagger';
import { SubOrder } from '../entities/sub-order.entity';

export class PaginatedSubOrderResponse extends PaginatedResponse<SubOrder> {
  @ApiProperty({ type: SubOrder, isArray: true })
  data: SubOrder[];
}
