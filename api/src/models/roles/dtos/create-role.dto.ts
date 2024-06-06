import { IsArray, IsOptional, IsUUID, NotEquals } from 'class-validator';
import { Entities, ROLE } from '@common/enums';
import { ApiProperty } from '@nestjs/swagger';
import { IsUnique } from '@common/decorators';
import { item_already_exist } from '@common/constants';

export class CreateRoleDto {
  @ApiProperty({ description: 'the rule name' })
  @IsUnique(Entities.Role, { message: item_already_exist('name') })
  @NotEquals(ROLE.SUPER_ADMIN)
  name: string;

  @ApiProperty({ description: 'the Ids of permissions' })
  @IsOptional()
  @IsUUID('all', { each: true })
  @IsArray({ message: 'must be an array' })
  permissionsIds: string[];
}
