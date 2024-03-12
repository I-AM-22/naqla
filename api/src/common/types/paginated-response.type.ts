import { ApiProperty } from '@nestjs/swagger';
import { GlobalEntity } from '../base';

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

export class SendConfirm {
  @ApiProperty()
  message: string;
}
