import { ApiProperty } from '@nestjs/swagger';
import { Employee } from '../entities/employee.entity';

export abstract class AuthEmployeeResponse {
  @ApiProperty()
  token: string;

  @ApiProperty({ type: Employee })
  employee: Employee;
}
