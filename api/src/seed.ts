import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { InitialDatabaseSeeder } from './database/seeders';
import { SeederModule } from './database/seeders/seeder.module';

async function bootstrap() {
  await NestFactory.createApplicationContext(SeederModule)
    .then((appContext) => {
      const logger = appContext.get(Logger);
      const seeder = appContext.get(InitialDatabaseSeeder);
      seeder
        .seed()
        .then(() => {
          logger.debug('Seeding complete!');
        })
        .catch((error) => {
          logger.error('Seeding failed!');
          throw error;
        })
        .finally(() => appContext.close());
    })
    .catch((error) => {
      throw error;
    });
}
bootstrap();
