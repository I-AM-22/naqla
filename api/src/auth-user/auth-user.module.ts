import { PassportModule } from '@nestjs/passport';
import { Module, Provider } from '@nestjs/common';
import { AuthUserController } from './controllers/auth-user.controller';
import { AuthUserService } from './services/auth-user.service';
import { JwtUserStrategy } from './strategy/jwt-user.strategy';
import { UsersModule } from '../models/users/users.module';
import { EmployeesModule } from '../models/employees/employees.module';
import { AdminsModule } from '../models/admins/admins.module';
import { AUTH_TYPES } from './interfaces/type';
import { OtpsModule } from '../models/otps/otps.module';

export const AuthUserServiceProvider: Provider = {
  provide: AUTH_TYPES.service,
  useClass: AuthUserService,
};
@Module({
  imports: [
    PassportModule.register({}),
    UsersModule,
    EmployeesModule,
    AdminsModule,
    OtpsModule,
  ],
  controllers: [AuthUserController],
  providers: [AuthUserServiceProvider, JwtUserStrategy],
  exports: [PassportModule],
})
export class AuthUserModule {}
