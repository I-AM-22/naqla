import { setSeederFactory } from 'typeorm-extension';
import { defaultPhoto } from '../../../common/constants';
import { Role } from '../../../models/roles';
import { ROLE } from '../../../common/enums';
import { Employee, EmployeePhoto } from '../../../models/employees';

export const employeeFactory = setSeederFactory(Employee, async (faker) =>
  Employee.create({
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    phone: faker.helpers.fromRegExp(/09[345689][0-9]{7}/),
    role: await Role.findOneBy({ name: ROLE.EMPLOYEE }),
    password: process.env.EMPLOYEE_PASSWORD,
    address: faker.location.streetAddress(),
    photos: [EmployeePhoto.create({ ...defaultPhoto })],
  }),
);
