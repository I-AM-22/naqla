import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';

export class UpdateWalletDto {
  @IsNotEmpty()
  @IsNumber()
  @ApiProperty()
  readonly cost: number;
}
