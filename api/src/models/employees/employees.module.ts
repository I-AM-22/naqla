import { Module, Provider } from '@nestjs/common';
import { EmployeesService } from './services/employees.service';
import { EmployeesController } from './controllers/employees.controller';
import { Employee } from './entities/employee.entity';
import { EmployeePhoto } from './entities/employee-photo.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { EmployeePhotoRepository } from './repositories/employee-photo.repository';
import { EmployeeRepository } from './repositories/employee.repository';
import { EMPLOYEE_TYPES } from './interfaces/type';
import { RolesModule } from '../roles/roles.module';
import { JwtEmployeeStrategy } from './strategy/jwt-employess.strategy';

export const EmployeesServiceProvider: Provider = {
  provide: EMPLOYEE_TYPES.service,
  useClass: EmployeesService,
};

export const EmployeeRepositoryProvider: Provider = {
  provide: EMPLOYEE_TYPES.repository.employee,
  useClass: EmployeeRepository,
};
export const EmployeePhotoRepositoryProvider: Provider = {
  provide: EMPLOYEE_TYPES.repository.photo,
  useClass: EmployeePhotoRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([Employee, EmployeePhoto]), RolesModule],
  controllers: [EmployeesController],
  providers: [
    EmployeePhotoRepositoryProvider,
    EmployeeRepositoryProvider,
    EmployeesServiceProvider,
    JwtEmployeeStrategy,
  ],
  exports: [EmployeePhotoRepositoryProvider, EmployeeRepositoryProvider, EmployeesServiceProvider],
})
export class EmployeesModule {}
