import { PartialType } from '@nestjs/swagger';
import { CreateSubOrderDto } from './create-sub-order.dto';

export class UpdateSubOrderDto extends PartialType(CreateSubOrderDto) {}
