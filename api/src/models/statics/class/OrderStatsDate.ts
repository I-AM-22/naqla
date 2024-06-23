import { ApiProperty } from '@nestjs/swagger';

export class OrderStatsDate {
  @ApiProperty()
  day: string;
  @ApiProperty()
  completedOrders: number;
  @ApiProperty()
  refusedOrders: number;
  @ApiProperty()
  AllOrders: number;
}
