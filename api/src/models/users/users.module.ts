import { Module, Provider } from '@nestjs/common';
import { UserRepository } from './repositories/user.repository';
import { UserPhotosRepository } from './repositories/user-photos.repository';
import { UserWalletRepository } from './repositories/user-wallet.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { UserWallet } from './entities/user-wallet.entity';
import { UserPhoto } from './entities/user-photo.entity';
import { UsersController } from './controllers/users.controller';
import { UsersService } from './services/users.service';
import { CitiesModule } from '../cities/cities.module';
import { USER_TYPES } from './interfaces/type';
import { RolesModule } from '../roles/roles.module';

export const UsersServiceProvider: Provider = {
  provide: USER_TYPES.service,
  useClass: UsersService,
};

export const UserRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.user,
  useClass: UserRepository,
};
export const UserPhotosRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.photos,
  useClass: UserPhotosRepository,
};

export const UserWalletRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.wallet,
  useClass: UserWalletRepository,
};
@Module({
  imports: [
    TypeOrmModule.forFeature([User, UserWallet, UserPhoto]),
    RolesModule,
    CitiesModule,
  ],
  controllers: [UsersController],
  providers: [
    UserPhotosRepositoryProvider,
    UserRepositoryProvider,
    UserWalletRepositoryProvider,
    UsersServiceProvider,
  ],
  exports: [
    UserPhotosRepositoryProvider,
    UserRepositoryProvider,
    UserWalletRepositoryProvider,
    UsersServiceProvider,
  ],
})
export class UsersModule {}
