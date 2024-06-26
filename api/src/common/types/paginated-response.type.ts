import { ApiProperty } from '@nestjs/swagger';
import { GlobalEntity } from '../base';

export class PaginatedResponse<T> {
  @ApiProperty()
  pageNumber: number;

  @ApiProperty()
  totalPages: number;

  @ApiProperty()
  totalDataCount: number;

  @ApiProperty({ type: GlobalEntity, isArray: true })
  data: T[];

  constructor(pageNumber: number, totalPages: number, totalDataCount: number, data: T[]) {
    this.pageNumber = pageNumber || 1;
    this.totalPages = totalPages || 1;
    this.totalDataCount = totalDataCount;
    this.data = data;
  }

  static pagination<T>(pageNumber: number, limit: number, totalDataCount: number, data: T[]): PaginatedResponse<T> {
    const totalPages = Math.ceil(totalDataCount / limit);

    return new PaginatedResponse(pageNumber, totalPages, totalDataCount, data);
  }
}

export class SendConfirm {
  @ApiProperty()
  message: string;
}
