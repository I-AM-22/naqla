import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsNumber, IsUUID, ValidateNested } from 'class-validator';

export class sub {
  @ApiProperty()
  @IsNumber()
  weight: number;

  @ApiProperty({ isArray: true, type: String })
  @IsUUID('all', { each: true })
  photos: string[];
}
export class CreateSubOrderDto {
  @ApiProperty()
  @IsUUID()
  orderId: string;
  @ApiProperty({ isArray: true, type: sub })
  @ValidateNested({ each: true })
  @Type(() => sub)
  subOrders: sub[];
}
