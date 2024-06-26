import { bad_req, data_not_found, denied_error } from '@common/constants';
import { AppError, CustomValidationError } from '@common/types';
import { applyDecorators } from '@nestjs/common';
import { ApiBadRequestResponse, ApiForbiddenResponse, ApiNotFoundResponse } from '@nestjs/swagger';

export function ApiMainErrorsResponse() {
  return applyDecorators(
    ApiBadRequestResponse({
      description: bad_req,
      type: CustomValidationError,
    }),
    ApiForbiddenResponse({
      description: denied_error,
      type: AppError,
    }),
    ApiNotFoundResponse({
      description: data_not_found,
      type: AppError,
    }),
  );
}
