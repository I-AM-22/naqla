import { Role } from '../../../roles';
import { CreateEmployeeDto, UpdateEmployeeDto } from '../../dtos';
import { EmployeePhoto } from '../../entities/employee-photo.entity';
import { Employee } from '../../entities/employee.entity';

export interface IEmployeeRepository {
  find(withDeleted: boolean): Promise<Employee[]>;

  findById(id: string, withDeleted?: boolean): Promise<Employee>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<Employee>;

  create(
    dto: CreateEmployeeDto,
    photo: EmployeePhoto,
    role: Role,
  ): Promise<Employee>;

  update(
    employee: Employee,
    dto: UpdateEmployeeDto,
    photo: EmployeePhoto,
  ): Promise<Employee>;
  // recover(employee: Employee): Promise<Employee>;

  remove(employee: Employee): Promise<void>;

  validate(id: string): Promise<Employee>;
}
