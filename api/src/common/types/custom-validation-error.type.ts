import { ApiPropertyOptional } from '@nestjs/swagger';
import { ValidationErrorType } from './validation-error.type';
import { AppError } from './app-error.type';

export class CustomValidationError extends AppError {
  @ApiPropertyOptional()
  errors: ValidationErrorType[];
}
