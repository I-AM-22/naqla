import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppConfig } from '@config/app';
import PostgresConfig from '@config/database/postgres';
import { PostgresService } from './postgres/postgres.service';

@Module({
  imports: [
    TypeOrmModule.forRootAsync({
      useClass: PostgresService,
      imports: [ConfigModule.forFeature(PostgresConfig), ConfigModule.forFeature(AppConfig)],
    }),
  ],
})
export class DatabaseModule {}
