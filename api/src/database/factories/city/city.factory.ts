import { setSeederFactory } from 'typeorm-extension';
import { City } from '../../../models/cities';

export const cityFactory = setSeederFactory(City, (faker) =>
  City.create({
    name: faker.location.city(),
  }),
);
