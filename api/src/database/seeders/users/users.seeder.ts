import type { DataSource } from 'typeorm';
import type { Seeder, SeederFactoryManager } from 'typeorm-extension';
import { User } from '@models/users/entities/user.entity';

export class UserSeeder implements Seeder {
  async run(dataSource: DataSource, factoryManager: SeederFactoryManager): Promise<void> {
    const userFactory = factoryManager.get(User);
    const users = await userFactory.saveMany(5);
    console.log('\nComplete seeding user,count: ' + users.length + '\n');
  }
}
