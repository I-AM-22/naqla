import { PassportModule } from '@nestjs/passport';
import { Module, Provider } from '@nestjs/common';
import { AuthController } from './controllers/auth.controller';
import { AuthService } from './services/auth.service';
import { JwtStrategy } from './strategy/jwt.strategy';
import { MailModule } from '../shared/mail/mail.module';
import { UsersModule } from '../models/users/users.module';
import { EmployeesModule } from '../models/employees/employees.module';
import { AdminsModule } from '../models/admins/admins.module';
import { RolesModule } from '../models/roles/roles.module';
import { AUTH_TYPES } from './interfaces/type';
import { OtpsModule } from '../models/otps/otps.module';

export const AuthServiceProvider: Provider = {
  provide: AUTH_TYPES.service,
  useClass: AuthService,
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
  controllers: [AuthController],
  providers: [AuthServiceProvider, JwtStrategy],
  exports: [PassportModule],
})
export class AuthModule {}
