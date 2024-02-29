import { Inject, Injectable } from '@nestjs/common';
import { ROLE } from '../../../common/enums';
import { Role } from '../../roles';
import { Repository, Equal } from 'typeorm';
import { defaultPhoto } from '../../../common/constants';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateEmployeeDto, UpdateEmployeeDto } from '../dtos';
import { Employee } from '../entities/employee.entity';
import { IEmployeeRepository } from '../interfaces/repositories/employee.repository.interface';
import { IEmployeePhotosRepository } from '../interfaces/repositories/employee-photos.repository.interface';
import { EMPLOYEE_TYPES } from '../interfaces/type';
import { BaseAuthRepo } from '../../../common/entities';

@Injectable()
export class EmployeeRepository
  extends BaseAuthRepo<Employee>
  implements IEmployeeRepository
{
  constructor(
    @InjectRepository(Employee)
    private readonly employeeRepo: Repository<Employee>,
    @Inject(EMPLOYEE_TYPES.repository.employee_photos)
    private readonly employeePhotosRepository: IEmployeePhotosRepository,
  ) {
    super(employeeRepo);
  }

  async create(dto: CreateEmployeeDto, role: Role) {
    const employee = this.employeeRepo.create({
      ...dto,
      role,
      photos: [],
    });
    employee.photos.push(this.employeePhotosRepository.create(defaultPhoto));
    await employee.save();
    return employee;
  }

  async find(withDeleted = false) {
    return this.employeeRepo.find({
      where: { role: withDeleted ? {} : { name: Equal(ROLE.EMPLOYEE) } },
      withDeleted,
      relations: { photos: true, role: true },
    });
  }

  async update(employee: Employee, dto: UpdateEmployeeDto): Promise<Employee> {
    employee.photos.push(
      await this.employeePhotosRepository.uploadPhoto(dto.photo),
    );
    Object.assign<Employee, any>(employee, {
      email: dto.email,
      name: dto.name,
      password: dto.password,
      address: dto.address,
    });
    await this.employeeRepo.save(employee);
    return this.findOneById(employee.id);
  }

  // async recover(employee: Employee): Promise<Employee> {
  //   return this.employeeRepo.recover(employee);
  // }

  async remove(employee: Employee): Promise<void> {
    await this.employeeRepo.softRemove(employee);
  }
}
