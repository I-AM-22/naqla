import { ApiProperty } from '@nestjs/swagger';
import { IsUUID } from 'class-validator';

export class AddAdvansToOrderDto {
  @ApiProperty()
  @IsUUID('all', { each: true })
  advantages: string[];
}
