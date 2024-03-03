import { setSeederFactory } from 'typeorm-extension';
import { User } from '../../../models/users/entities/user.entity';
import { UserPhoto } from '../../../models/users';
import { defaultPhoto } from '../../../common/constants';
import { Role } from '../../../models/roles';
import { ROLE } from '../../../common/enums';
import { Wallet } from '../../../models/users/entities/wallet.entity';

export const userFactory = setSeederFactory(User, async (faker) =>
  User.create({
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    phone: faker.helpers.fromRegExp(/09[1-9]{8}/),
    password: process.env.USER_PASSWORD,
    role: await Role.findOneBy({ name: ROLE.USER }),
    photos: [UserPhoto.create({ ...defaultPhoto })],
    wallet: Wallet.create(),
  }),
);