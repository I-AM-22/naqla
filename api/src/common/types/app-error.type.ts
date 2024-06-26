import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { ErrorType } from '@common/enums/error-type.enum';

export class AppError {
  @ApiProperty({ enum: ErrorType })
  type: string;

  @ApiPropertyOptional()
  message: string;
}
