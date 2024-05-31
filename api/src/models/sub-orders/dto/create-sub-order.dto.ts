import { ApiProperty } from '@nestjs/swagger';
import { IsNumber, IsUUID } from 'class-validator';

export class CreateSubOrderDto {
  @ApiProperty()
  @IsUUID()
  orderId: string;

  @ApiProperty()
  @IsNumber()
  weight: number;

  @ApiProperty()
  @IsUUID('all', { each: true })
  photos: string[];
}
