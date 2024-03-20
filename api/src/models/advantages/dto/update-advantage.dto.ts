import { PartialType } from '@nestjs/swagger';
import { CreateAdvantageDto } from './create-advantage.dto';

export class UpdateAdvantageDto extends PartialType(CreateAdvantageDto) {}
