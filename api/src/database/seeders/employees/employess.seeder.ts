import type { DataSource } from 'typeorm';
import type { Seeder, SeederFactoryManager } from 'typeorm-extension';
import { Employee } from '@models/employees/entities/employee.entity';

export class EmployeeSeeder implements Seeder {
  async run(dataSource: DataSource, factoryManager: SeederFactoryManager): Promise<void> {
    const employeeFactory = factoryManager.get(Employee);
    const employees = await employeeFactory.saveMany(5);
    console.log('\nComplete seeding employee,count: ' + employees.length + '\n');
  }
}
