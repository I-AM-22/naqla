import { Type } from 'class-transformer';
import { IsNumber, IsUUID, ValidateNested } from 'class-validator';

import { ApiProperty } from '@nestjs/swagger';

export class CreateSubOrderDto {
  @ApiProperty()
  @IsNumber()
  weight: number;

  @ApiProperty({ isArray: true, type: String })
  @IsUUID('all', { each: true })
  photos: string[];
}

export class CreateSubOrdersDto {
  @ApiProperty()
  @IsUUID()
  orderId: string;

  @ApiProperty({ isArray: true, type: CreateSubOrderDto })
  @ValidateNested({ each: true })
  @Type(() => CreateSubOrderDto)
  subOrders: CreateSubOrderDto[];
}
