import { LoginDto } from '../../../auth-user';
import { PaginatedResponse } from '../../../common/types';
import { Employee } from '../entities/employee.entity';
import { CreateEmployeeDto, UpdateEmployeeDto } from './../dtos'; // Import necessary DTOs
import { AuthEmployeeResponse } from './auth-employee.interface';

export interface IEmployeeService {
  login(dto: LoginDto): Promise<AuthEmployeeResponse>;

  find(withDeleted: boolean): Promise<Employee[] | PaginatedResponse<Employee>>;

  findOne(id: string, withDeleted?: boolean): Promise<Employee>;

  create(dto: CreateEmployeeDto): Promise<Employee>;

  update(id: string, dto: UpdateEmployeeDto): Promise<Employee>;

  // recover(id: string): Promise<Employee>;

  remove(id: string): Promise<void>;
}
export const IEmployeeService = Symbol('IEmployeeService');
