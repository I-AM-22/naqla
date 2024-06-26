import { BadRequestException } from '@nestjs/common';
import { ValidationError } from 'class-validator';
import { ValidationErrorType } from '../types';

function consOrChild(error: ValidationError, formattedErrors: ValidationErrorType[], father?: string[]) {
  const { property, constraints, children } = error;
  if (constraints) {
    for (const key in constraints) {
      if (constraints.hasOwnProperty(key)) {
        formattedErrors.push({
          message: constraints[key],
          path: father ? [...father, property] : [property],
        });
      }
    }
    return formattedErrors;
  }
  father = father ? father : [];
  father.push(property);
  children.forEach((error) => {
    consOrChild(error, formattedErrors, father);
  });
}

export const errorsFormat = (errors: any) => {
  const formattedErrors = [];
  errors.forEach((error) => {
    consOrChild(error, formattedErrors);
  });
  throw new BadRequestException({ errors: formattedErrors });
};
