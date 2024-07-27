import { HyperPayMethods } from '@common/enums/hyper-pay-method.enum';
import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';

export class AcceptanceDto {
  @ApiProperty({ default: HyperPayMethods.mada })
  @IsNotEmpty()
  @IsEnum(HyperPayMethods)
  readonly methodType: HyperPayMethods;
}
