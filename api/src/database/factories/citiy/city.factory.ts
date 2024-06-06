import { setSeederFactory } from 'typeorm-extension';
import { City } from '@models/cities/entities/city.entity';

export const cityFactory = setSeederFactory(City, (faker) =>
  City.create({
    name: faker.location.city(),
  }),
);
