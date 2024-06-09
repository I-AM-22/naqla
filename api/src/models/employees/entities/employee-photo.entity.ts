import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { BasePhoto } from '@common/base';
import { Employee } from './employee.entity';
import { Exclude } from 'class-transformer';

@Entity({ name: 'employees_photos' })
export class EmployeePhoto extends BasePhoto {
  @ManyToOne(() => Employee, (employee) => employee.photos)
  @JoinColumn({ name: 'employeeId' })
  employee: Employee;

  @Exclude()
  @Column()
  employeeId: string;
}
