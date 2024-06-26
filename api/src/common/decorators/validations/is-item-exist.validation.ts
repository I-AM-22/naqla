import { Injectable } from '@nestjs/common';
import * as fs from 'fs';
import {
  ValidatorConstraint,
  ValidatorConstraintInterface,
  ValidationOptions,
  registerDecorator,
} from 'class-validator';

@ValidatorConstraint({ name: 'isItemExist', async: true })
@Injectable()
export class IsItemExistConstraint implements ValidatorConstraintInterface {
  async validate(value: any) {
    if (!fs.existsSync(value.photo)) {
      return false;
    }
    return true;
  }
}

export function IsItemExist(validationOptions?: ValidationOptions): PropertyDecorator {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: IsItemExistConstraint,
    });
  };
}
