import { IsEnum, NotEquals } from 'class-validator';
import { Action, Entities } from '@common/enums';
import { IPermission } from '../interfaces';
import { ApiProperty } from '@nestjs/swagger';

export class CreatePermissionDto implements IPermission {
  @ApiProperty({ enum: Action })
  @IsEnum(Action)
  action: Action;

  @ApiProperty({ enum: Entities })
  @IsEnum(Entities)
  @NotEquals(Entities.All)
  subject: Entities;
}
