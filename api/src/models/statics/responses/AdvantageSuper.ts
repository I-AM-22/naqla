import { ApiProperty } from '@nestjs/swagger';

export class AdvantageSuper {
  @ApiProperty()
  advantage: string;

  @ApiProperty()
  percentage: number;
}

export class ListAdvantageSuper {
  @ApiProperty({ isArray: true, type: AdvantageSuper })
  orders: AdvantageSuper[];

  @ApiProperty({ isArray: true, type: AdvantageSuper })
  cars: AdvantageSuper[];
}
