import * as Joi from 'joi';
import { ConfigModule } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { CloudinaryModule } from './shared/cloudinary';
import {
  IsExistConstraint,
  IsPhotoExistConstraint,
  IsUniqueConstraint,
} from './common/decorators';
import { PhotosModule } from './photos/photos.module';
import { PhotoCleanupModule } from './jobs/photo-cleanup';
import { AdminsModule } from './models/admins/admins.module';
import { PermissionsModule } from './models/permissions/permissions.module';
import { RolesModule } from './models/roles/roles.module';
import { UsersModule } from './models/users/users.module';
import { DatabaseModule } from './providers/database';
import { CaslModule } from './shared/casl';
import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { CitiesModule } from './models/cities/cities.module';
import { EmployeesModule } from './models/employees/employees.module';
import { JwtTokenModule } from './shared/jwt';
import { DevtoolsModule } from '@nestjs/devtools-integration';
import { RedisStoreModule } from './shared/redis-store/redis-store.module';
import { LoggerMiddleware } from './common/middlewares';
import { LoggerModule } from './shared/logger/logger.module';
import { OtpsModule } from './models/otps/otps.module';
import { DriversModule } from './models/drivers/drivers.module';
import { AuthUserModule } from './auth-user/auth-user.module';
import { AuthDriverModule } from './auth-driver/auth-driver.module';
import { APP_GUARD } from '@nestjs/core';
import { JwtGuard } from './common/guards';

@Module({
  imports: [
    JwtModule.register({ global: true }),
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

    DevtoolsModule.register({
      http: process.env.ENV !== 'production',
      port: 8001,
    }),
    AuthUserModule,
    UsersModule,
    AuthDriverModule,
    DriversModule,
    AdminsModule,
    EmployeesModule,
    CitiesModule,
    RolesModule,
    PermissionsModule,
    PhotosModule,
    DatabaseModule,
    JwtTokenModule,
    PhotoCleanupModule,
    CaslModule,
    CloudinaryModule,
    RedisStoreModule,
    LoggerModule,
    OtpsModule,
  ],
  providers: [
    IsUniqueConstraint,
    IsExistConstraint,
    IsPhotoExistConstraint,

    {
      provide: APP_GUARD,
      useClass: JwtGuard,
    },
  ],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LoggerMiddleware).forRoutes({
      path: '*',
      method: RequestMethod.ALL,
    });
  }
}
