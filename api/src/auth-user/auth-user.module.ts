import { PassportModule } from '@nestjs/passport';
import { Module } from '@nestjs/common';
import { AuthUserController } from './controllers/auth-user.controller';
import { JwtUserStrategy } from './strategy/jwt-user.strategy';
import { UsersModule } from '@models/users/users.module';
import { EmployeesModule } from '@models/employees/employees.module';
import { AdminsModule } from '@models/admins/admins.module';
import { OtpsModule } from '@models/otps/otps.module';
import { AuthUserService } from './services/auth-user.service';

@Module({
  imports: [PassportModule.register({}), UsersModule, EmployeesModule, AdminsModule, OtpsModule],
  controllers: [AuthUserController],
  providers: [AuthUserService, JwtUserStrategy],
  exports: [PassportModule],
})
export class AuthUserModule {}
