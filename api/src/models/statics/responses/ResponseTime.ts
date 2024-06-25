import { ApiProperty } from '@nestjs/swagger';

class Time {
  @ApiProperty()
  hours: number;

  @ApiProperty()
  minutes: number;

  @ApiProperty()
  seconds: number;

  @ApiProperty()
  milliseconds: number;
}
export class ResponseTime {
  @ApiProperty()
  today: Time;

  @ApiProperty()
  yesterday: Time;
}
