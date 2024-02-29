import { ApiProperty } from '@nestjs/swagger';

import { IsArray, IsOptional, IsUUID } from 'class-validator';
import { Permission } from './../../permissions';

export class UpdateRoleDto {
  @IsArray()
  @IsOptional()
  @IsUUID('all', { each: true })
  @ApiProperty()
  permissionsIds: string[];
}
