import { PassportModule } from '@nestjs/passport';
import { Module, Provider } from '@nestjs/common';
import { AuthUserController } from './controllers/auth-user.controller';
import { AuthUserService } from './services/auth-user.service';
import { JwtStrategy } from './strategy/jwt-user.strategy';
import { MailModule } from '../shared/mail/mail.module';
import { UsersModule } from '../models/users/users.module';
import { EmployeesModule } from '../models/employees/employees.module';
import { AdminsModule } from '../models/admins/admins.module';
import { RolesModule } from '../models/roles/roles.module';
import { AUTH_TYPES } from './interfaces/type';
import { OtpsModule } from '../models/otps/otps.module';

export const AuthUserServiceProvider: Provider = {
  provide: AUTH_TYPES.service,
  useClass: AuthUserService,
};
@Module({
  imports: [
    PassportModule.register({}),
    MailModule,
    UsersModule,
    EmployeesModule,
    AdminsModule,
    RolesModule,
    OtpsModule,
  ],
  controllers: [AuthUserController],
  providers: [AuthUserServiceProvider, JwtStrategy],
  exports: [PassportModule],
})
export class AuthUserModule {}
