import { PaginatedResponse } from '../../../../common/types';
import {
  CreateEmployeeDto,
  LoginEmployeeDto,
  UpdateEmployeeDto,
} from '../../dtos';
import { Employee } from '../../entities/employee.entity';
import { AuthEmployeeResponse } from '../auth-employee.interface';

export interface IEmployeesService {
  login(dto: LoginEmployeeDto): Promise<AuthEmployeeResponse>;

  find(withDeleted: boolean): Promise<Employee[] | PaginatedResponse<Employee>>;

  findOne(id: string, withDeleted?: boolean): Promise<Employee>;

  create(dto: CreateEmployeeDto): Promise<Employee>;

  update(id: string, dto: UpdateEmployeeDto): Promise<Employee>;

  // recover(id: string): Promise<Employee>;
  validate(id: string, iat: number): Promise<Employee>;

  delete(id: string): Promise<void>;
}
