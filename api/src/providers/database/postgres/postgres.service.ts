import { Inject, Injectable } from '@nestjs/common';
import { TypeOrmOptionsFactory, TypeOrmModuleOptions } from '@nestjs/typeorm';
import { ConfigType } from '@nestjs/config';
import PostgresConfig from '@config/database/postgres';
import { AppConfig } from '@config/app';
import { DataSourceOptions } from 'typeorm';

@Injectable()
export class PostgresService implements TypeOrmOptionsFactory {
  constructor(
    @Inject(PostgresConfig.KEY)
    private readonly postgresConfig: ConfigType<typeof PostgresConfig>,
    @Inject(AppConfig.KEY)
    private readonly appConfig: ConfigType<typeof AppConfig>,
  ) {}
  createTypeOrmOptions(): TypeOrmModuleOptions {
    if (this.appConfig.env === 'production') {
      return {
        type: 'postgres',
        url: this.postgresConfig.url,
        entities: [__dirname + '/../../../models/**/entities/*.entity.{js,ts}'],
        synchronize: true,
        ssl: {
          rejectUnauthorized: false,
          ca: this.postgresConfig.ca,
        },
      };
    }

    const type: DataSourceOptions['type'] = 'postgres';
    const entities: DataSourceOptions['entities'] = [__dirname + '/../../../models/**/entities/*.entity.{js,ts}'];

    return {
      type,
      host: this.postgresConfig.host,
      port: this.postgresConfig.port,
      username: this.postgresConfig.username,
      password: this.postgresConfig.password,
      database: this.postgresConfig.database,
      synchronize: this.postgresConfig.synchronize === 'true',
      dropSchema: false,
      keepConnectionAlive: true,
      logging: this.appConfig.env !== 'production',
      entities,
      migrations: [__dirname + '/migrations/**/*{.ts,.js}'],
      cli: {
        entitiesDir: 'src',
        migrationsDir: 'src/database/migrations',
        subscribersDir: 'subscriber',
      },
      sslCA: this.postgresConfig.ca,
      sslKey: this.postgresConfig.key,
      sslCert: this.postgresConfig.cert,
      ssl: this.postgresConfig.ssl === 'true',
      extra: {
        // based on https://node-postgres.com/apis/pool
        // max connection pool size
        max: this.postgresConfig.max,
      },
    } as TypeOrmModuleOptions;
  }
}
