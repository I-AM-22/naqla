import { PassportModule } from '@nestjs/passport';
import { Module, Provider } from '@nestjs/common';
import { AuthDriverController } from './controllers/auth-driver.controller';
import { AuthDriverService } from './services/auth-driver.service';
import { DriversModule } from '@models/drivers/drivers.module';
import { RolesModule } from '@models/roles/roles.module';
import { AUTH_DRIVER_TYPES } from './interfaces/type';
import { OtpsModule } from '@models/otps/otps.module';
import { JwtDriverStrategy } from './strategy/jwt-driver.strategy';

export const AuthDriverServiceProvider: Provider = {
  provide: AUTH_DRIVER_TYPES.service,
  useClass: AuthDriverService,
};
@Module({
  imports: [PassportModule.register({}), DriversModule, RolesModule, OtpsModule],
  controllers: [AuthDriverController],
  providers: [AuthDriverServiceProvider, JwtDriverStrategy],
  exports: [PassportModule],
})
export class AuthDriverModule {}
