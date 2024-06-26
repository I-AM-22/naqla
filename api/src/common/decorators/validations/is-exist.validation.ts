import { Injectable } from '@nestjs/common';
import {
  registerDecorator,
  ValidationArguments,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';
import { DataSource } from 'typeorm';

@ValidatorConstraint({ name: 'isExist', async: true })
@Injectable()
export class IsExistConstraint implements ValidatorConstraintInterface {
  constructor(private dataSource: DataSource) {}
  async validate(value: any, args: ValidationArguments) {
    return this.dataSource
      .getRepository(args.constraints[0])
      .findOne({
        where: {
          email: value,
        },
        withDeleted: true,
      })
      .then((entity) => {
        if (!entity) return false;
        return true;
      });
  }
}

export function IsExist(entity: string, validationOptions?: ValidationOptions): PropertyDecorator {
  return function (object: object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [entity],
      validator: IsExistConstraint,
    });
  };
}
