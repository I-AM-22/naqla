import type { DataSource } from 'typeorm';
import type { Seeder, SeederFactoryManager } from 'typeorm-extension';
import { City } from '@models/cities/entities/city.entity';

export class CitySeeder implements Seeder {
  async run(dataSource: DataSource, factoryManager: SeederFactoryManager): Promise<void> {
    const cityFactory = factoryManager.get(City);
    const cities = await cityFactory.saveMany(3);
    console.log('\nComplete seeding cities,count: ' + cities.length + '\n');
  }
}
