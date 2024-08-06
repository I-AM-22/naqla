import { UpdateUserPhoneDto } from '../../../../auth-user';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles/entities/role.entity';
import { CreateUserDto, UpdateUserDto } from '../../dtos';
import { UserPhoto } from '../../entities/user-photo.entity';
import { User } from '../../entities/user.entity';
import { UserWallet } from '../../entities/user-wallet.entity';

export interface IUserRepository {
  find(
    page: number,
    limit: number,
    withActive?: boolean,
    withDeleted?: boolean,
  ): Promise<PaginatedResponse<User> | User[]>;

  staticsUser(page: number, limit: number, withDeleted: boolean): Promise<PaginatedResponse<User>>;

  countUser(): Promise<number>;

  findById(id: string, withDeleted?: boolean): Promise<User>;

  findByIdForDelete(id: string): Promise<User>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<User>;

  findByIdForThings(id: string): Promise<User>;

  create(dto: CreateUserDto, wallet: UserWallet, photo: UserPhoto, role: Role): Promise<User>;

  confirm(nonConfirmedUser: User): Promise<User>;

  update(user: User, dto: UpdateUserDto, photo: UserPhoto): Promise<User>;

  updatePhone(user: User, dto: UpdateUserPhoneDto): Promise<User>;

  delete(id: string): Promise<void>;

  deactivate(id: string): Promise<void>;

  validate(id: string): Promise<User>;
}
