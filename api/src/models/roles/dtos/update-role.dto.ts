import { ApiProperty } from '@nestjs/swagger';

import { IsArray, IsOptional, IsUUID } from 'class-validator';

export class UpdateRoleDto {
  @IsArray()
  @IsOptional()
  @IsUUID('all', { each: true })
  @ApiProperty()
  permissionsIds: string[];
}
