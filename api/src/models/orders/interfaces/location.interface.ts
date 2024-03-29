import { ApiProperty } from '@nestjs/swagger';

export class Location {
  @ApiProperty()
  longitude: number;

  @ApiProperty()
  latitude: number;

  @ApiProperty()
  region: string;

  @ApiProperty()
  street: string;
}
