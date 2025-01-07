import { PassportModule } from '@nestjs/passport';
import { Module } from '@nestjs/common';
import { AuthDriverController } from './controllers/auth-driver.controller';
import { DriversModule } from '@models/drivers/drivers.module';
import { RolesModule } from '@models/roles/roles.module';
import { OtpsModule } from '@models/otps/otps.module';
import { JwtDriverStrategy } from './strategy/jwt-driver.strategy';
import { AuthDriverService } from './services/auth-driver.service';

@Module({
  imports: [PassportModule.register({}), DriversModule, RolesModule, OtpsModule],
  controllers: [AuthDriverController],
  providers: [AuthDriverService, JwtDriverStrategy],
  exports: [PassportModule],
})
export class AuthDriverModule {}
