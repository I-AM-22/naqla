import { ApiProperty } from '@nestjs/swagger';
import { IsUUID } from 'class-validator';

export class AddAdvansToCarDto {
  @ApiProperty()
  @IsUUID('all', { each: true })
  advantages: string[];
}
