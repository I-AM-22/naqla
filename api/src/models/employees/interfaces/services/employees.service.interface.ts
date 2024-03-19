import { LoginUserDto } from '../../../../auth-user';
import { PaginatedResponse } from '../../../../common/types';
import { CreateEmployeeDto, UpdateEmployeeDto } from '../../dtos';
import { Employee } from '../../entities/employee.entity';
import { AuthEmployeeResponse } from '../auth-employee.interface';

export interface IEmployeesService {
  login(dto: LoginUserDto): Promise<AuthEmployeeResponse>;

  find(role: string): Promise<Employee[] | PaginatedResponse<Employee>>;

  findOne(id: string, role?: string): Promise<Employee>;

  create(dto: CreateEmployeeDto): Promise<Employee>;

  update(id: string, dto: UpdateEmployeeDto): Promise<Employee>;

  validate(id: string, iat: number): Promise<Employee>;

  // recover(id: string): Promise<Employee>;

  remove(id: string): Promise<void>;
}
