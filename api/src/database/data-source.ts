import 'reflect-metadata';
import { DataSource, DataSourceOptions } from 'typeorm';
import { SeederOptions } from 'typeorm-extension';

const type: DataSourceOptions['type'] = 'postgres';
const entities: DataSourceOptions['entities'] = [
  __dirname + '/../models/**/entities/*.entity.{js,ts}',
];
const factories: SeederOptions['factories'] = [
  __dirname + '/../database/factories/**/*.factory.{js,ts}',
];
const seeds: SeederOptions['seeds'] = [
  __dirname + '/../database/seeders/**/*.seeder.{js,ts}',
];

const dataSourceOptions = new DataSource({
  type,
  factories,
  seeds,
  host: process.env.POSTGRES_HOST,
  port: Number(process.env.POSTGRES_PORT),
  username: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASS,
  database: process.env.POSTGRES_NAME,
  synchronize: process.env.POSTGRES_SYNCHRONIZE === 'true',
  dropSchema: false,
  keepConnectionAlive: true,
  logging: process.env.NODE_ENV !== 'production',
  entities,
  migrations: ['src/database' + '/migrations/**/*{.ts,.js}'],
  cli: {
    entitiesDir: 'src',
    migrationsDir: 'src/database/migrations',
    subscribersDir: 'subscriber',
  },
  sslCA: process.env.POSTGRES_CA ?? undefined,
  sslKey: process.env.POSTGRES_KEY ?? undefined,
  sslCert: process.env.POSTGRES_CERT ?? undefined,
  ssl:
    process.env.POSTGRES_SSL_ENABLED === 'true'
      ? process.env.POSTGRES_SSL_ENABLED
      : undefined,
  extra: {
    // based on https://node-postgres.com/api/pool
    // max connection pool size
    max: process.env.POSTGRES_MAX_CONNECTIONS
      ? parseInt(process.env.POSTGRES_MAX_CONNECTIONS, 10)
      : 100,
  },
} as DataSourceOptions & SeederOptions);

export default dataSourceOptions;