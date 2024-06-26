import { Injectable } from '@nestjs/common';
import * as fs from 'fs';
import {
  ValidatorConstraint,
  ValidatorConstraintInterface,
  ValidationOptions,
  registerDecorator,
} from 'class-validator';

@ValidatorConstraint({ name: 'isPhotoExist', async: true })
@Injectable()
export class IsPhotoExistConstraint implements ValidatorConstraintInterface {
  async validate(value: any) {
    if (!fs.existsSync(value)) {
      return false;
    }
    return true;
  }
}

export function IsPhotoExist(validationOptions?: ValidationOptions): PropertyDecorator {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: IsPhotoExistConstraint,
    });
  };
}
