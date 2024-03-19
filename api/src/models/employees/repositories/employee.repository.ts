import { Inject, Injectable } from '@nestjs/common';
import { ROLE } from '../../../common/enums';
import { Role } from '../../roles';
import { Repository, Equal } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateEmployeeDto, UpdateEmployeeDto } from '../dtos';
import { Employee } from '../entities/employee.entity';
import { IEmployeeRepository } from '../interfaces/repositories/employee.repository.interface';
import { EMPLOYEE_TYPES } from '../interfaces/type';
import { BaseAuthRepo } from '../../../common/base';
import { EmployeePhoto } from '../entities/employee-photo.entity';
import { IPhotosRepository } from '../../../common/interfaces';

@Injectable()
export class EmployeeRepository
  extends BaseAuthRepo<Employee>
  implements IEmployeeRepository
{
  constructor(
    @InjectRepository(Employee)
    private readonly employeeRepo: Repository<Employee>,
    @Inject(EMPLOYEE_TYPES.repository.employee_photos)
    private readonly employeePhotosRepository: IPhotosRepository<EmployeePhoto>,
  ) {
    super(employeeRepo);
  }

  async create(dto: CreateEmployeeDto, photo: EmployeePhoto, role: Role) {
    const employee = this.employeeRepo.create({
      ...dto,
      role,
      photos: [photo],
    });
    await this.employeeRepo.save(employee);
    return employee;
  }

  async find(withDeleted = false) {
    return this.employeeRepo.find({
      where: { role: withDeleted ? {} : { name: Equal(ROLE.EMPLOYEE) } },
      withDeleted,
      relations: { photos: true, role: true },
    });
  }

  async update(
    employee: Employee,
    dto: UpdateEmployeeDto,
    photo?: EmployeePhoto,
  ): Promise<Employee> {
    if (photo) employee.photos.push(photo);
    Object.assign<Employee, any>(employee, {
      phone: dto.phone,
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
