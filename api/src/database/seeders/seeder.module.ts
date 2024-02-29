import { Module } from '@nestjs/common';
import { PermissionsSeederModule } from './permissions';
import { DatabaseModule } from '../../providers/database';
import { InitialDatabaseSeeder } from './seeder';
import { ConfigModule } from '@nestjs/config';
import { SuperadminModule } from './superadmin';
import { RolesSeederModule } from './roles';
import { LoggerModule } from '../../shared/logger/logger.module';
import * as Joi from 'joi';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      validationSchema: Joi.object({
        ENV: Joi.string().required(),
        JWT_SECRET: Joi.string(),
        JWT_EXPIRES_IN: Joi.string(),
        POSTGRES_USER: Joi.string().required(),
        POSTGRES_PASS: Joi.string().required(),
        POSTGRES_NAME: Joi.string().required(),
        POSTGRES_HOST: Joi.string().required(),
        POSTGRES_PORT: Joi.number().required(),
      }),
      // load: [postgresConfig],
    }),
    DatabaseModule,
    PermissionsSeederModule,
    SuperadminModule,
    RolesSeederModule,
    LoggerModule,
  ],
  providers: [InitialDatabaseSeeder],
})
export class SeederModule {}
