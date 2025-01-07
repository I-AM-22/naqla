import { Module, Provider } from '@nestjs/common';
import { UserRepository } from './repositories/user.repository';
import { UserPhotoRepository } from './repositories/user-photos.repository';
import { UserWalletRepository } from './repositories/user-wallet.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { UserWallet } from './entities/user-wallet.entity';
import { UserPhoto } from './entities/user-photo.entity';
import { UsersController } from './controllers/users.controller';
import { CitiesModule } from '../cities/cities.module';
import { USER_TYPES } from './interfaces/type';
import { RolesModule } from '../roles/roles.module';
import { SubOrdersModule } from '@models/sub-orders/sub-orders.module';
import { UsersService } from './services/users.service';

export const UserRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.user,
  useClass: UserRepository,
};
export const UserPhotoRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.photo,
  useClass: UserPhotoRepository,
};

export const UserWalletRepositoryProvider: Provider = {
  provide: USER_TYPES.repository.wallet,
  useClass: UserWalletRepository,
};
@Module({
  imports: [TypeOrmModule.forFeature([User, UserWallet, UserPhoto]), RolesModule, CitiesModule, SubOrdersModule],
  controllers: [UsersController],
  providers: [
    UserPhotoRepositoryProvider,
    UserRepositoryProvider,
    UserWalletRepositoryProvider,
    UserWalletRepository,
    UserRepository,
    UsersService,
  ],
  exports: [
    UserRepository,
    UserPhotoRepositoryProvider,
    UserRepositoryProvider,
    UserWalletRepositoryProvider,
    UserWalletRepository,
    UsersService,
  ],
})
export class UsersModule {}
