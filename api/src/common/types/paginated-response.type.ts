import { ApiProperty } from '@nestjs/swagger';
import { GlobalEntity } from '../entities';

export class PaginatedResponse<T> {
  @ApiProperty()
  pageNumber: number;

  @ApiProperty()
  totalPages: number;

  @ApiProperty()
  totalDataCount: number;

  @ApiProperty({ type: GlobalEntity })
  data: T[];
}
