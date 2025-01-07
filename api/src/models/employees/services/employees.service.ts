import { Injectable, UnauthorizedException, NotFoundException, Inject } from '@nestjs/common';
import { Entities, ROLE } from '@common/enums';
import { JwtTokenService } from '../../../shared/jwt';
import { CreateEmployeeDto } from '../dtos/create-employee.dto';
import { UpdateEmployeeDto } from '../dtos/update-employee.dto';
import { Employee } from '../entities/employee.entity';
import { AuthEmployeeResponse } from '../interfaces';
import { defaultPhotoUrl, incorrect_credentials, item_not_found, password_changed_recently } from '@common/constants';
import { IEmployeeRepository } from '../interfaces/repositories/employee.repository.interface';
import { EMPLOYEE_TYPES } from '../interfaces/type';
import { LoginEmployeeDto } from '../dtos';
import { IPhotoRepository } from '@common/interfaces';
import { EmployeePhoto } from '../entities/employee-photo.entity';
import { RolesService } from '@models/roles/services/roles.service';

@Injectable()
export class EmployeesService {
  constructor(
    private jwtTokenService: JwtTokenService,
    @Inject(EMPLOYEE_TYPES.repository.employee)
    private employeeRepository: IEmployeeRepository,
    @Inject(EMPLOYEE_TYPES.repository.photo)
    private employeePhotoRepository: IPhotoRepository<EmployeePhoto>,
    private rolesService: RolesService,
  ) {}

  async login(dto: LoginEmployeeDto): Promise<AuthEmployeeResponse> {
    const employee = await this.employeeRepository.findOneByPhone(dto.phone);
    if (!employee || !(await employee.verifyHash(employee.password, dto.password))) {
      throw new UnauthorizedException(incorrect_credentials);
    }
    const token = await this.jwtTokenService.signToken(employee.id, Entities.Employee);
    return { token, employee };
  }

  async find(): Promise<Employee[]> {
    return this.employeeRepository.find();
  }

  async findOne(id: string, withDeleted?: boolean): Promise<Employee> {
    const employee = await this.employeeRepository.findById(id, withDeleted);
    if (!employee) {
      throw new NotFoundException(item_not_found(Entities.Employee));
    }
    return employee;
  }

  async create(dto: CreateEmployeeDto): Promise<Employee> {
    const role = await this.rolesService.findByName(ROLE.EMPLOYEE);
    let photo;
    if (dto.photo) photo = await this.employeePhotoRepository.uploadPhoto(dto.photo);
    else photo = await this.employeePhotoRepository.uploadPhoto(defaultPhotoUrl);

    return this.employeeRepository.create(dto, photo, role);
  }

  async update(id: string, dto: UpdateEmployeeDto): Promise<Employee> {
    const employee = await this.findOne(id);
    const photo = await this.employeePhotoRepository.uploadPhoto(dto.photo);
    return this.employeeRepository.update(employee, dto, photo);
  }

  // async recover(id: string): Promise<Employee> {
  //   const employee = await this.findOne(id, true);
  //   await this.employeeRepository.recover(employee);
  //   return employee;
  // }

  async delete(id: string): Promise<void> {
    const emp = await this.findOne(id);
    await this.employeeRepository.delete(emp);
    return;
  }

  async validate(id: string, iat: number): Promise<Employee> {
    const emp = await this.employeeRepository.findById(id);

    if (!emp) {
      throw new UnauthorizedException('The user is not here');
    }

    if (emp.isPasswordChanged(iat)) {
      throw new UnauthorizedException(password_changed_recently);
    }

    return emp;
  }
}
