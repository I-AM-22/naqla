import { registerAs } from '@nestjs/config';

const PostgresConfig = registerAs('postgres', () => ({
  username: process.env.POSTGRES_USER,
  database: process.env.POSTGRES_NAME,
  password: process.env.POSTGRES_PASS,
  port: Number(process.env.POSTGRES_PORT),
  host: process.env.POSTGRES_HOST,
  url: process.env.POSTGRES_URL,
  synchronize: process.env.POSTGRES_SYNCHRONIZE,
  max: process.env.POSTGRES_MAX_CONNECTIONS,
  ssl: process.env.POSTGRES_SSL_ENABLED,
  ca: process.env.POSTGRES_CA,
  key: process.env.POSTGRES_KEY,
  cert: process.env.POSTGRES_CERT,
}));
export default PostgresConfig;
