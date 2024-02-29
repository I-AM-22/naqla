import { BadRequestException, Injectable } from '@nestjs/common';
import * as fs from 'fs';
import {
  ValidatorConstraint,
  ValidatorConstraintInterface,
  ValidationArguments,
  ValidationOptions,
  registerDecorator,
} from 'class-validator';

@ValidatorConstraint({ name: 'isPhotoExist', async: true })
@Injectable()
export class IsPhotoExistConstraint implements ValidatorConstraintInterface {
  async validate(value: any, args: ValidationArguments) {
    if (!fs.existsSync(value)) {
      return false;
    }
    return true;
  }
}

export function IsPhotoExist(
  validationOptions?: ValidationOptions,
): PropertyDecorator {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: IsPhotoExistConstraint,
    });
  };
}
