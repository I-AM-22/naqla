import { setSeederFactory } from 'typeorm-extension';
import { User } from '@models/users/entities/user.entity';
import { UserPhoto } from '@models/users/entities/user-photo.entity';
import { defaultPhoto } from '@common/constants';
import { Role } from '@models/roles/entities/role.entity';
import { ROLE } from '@common/enums';
import { UserWallet } from '@models/users/entities/user-wallet.entity';

export const userFactory = setSeederFactory(User, async (faker) =>
  User.create({
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    phone: faker.helpers.fromRegExp(/09[345689][0-9]{7}/),
    role: await Role.findOneBy({ name: ROLE.USER }),
    photos: [UserPhoto.create({ ...defaultPhoto })],
    wallet: UserWallet.create(),
    active: true,
  }),
);
