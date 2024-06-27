import { UpdateUserPhoneDto } from '../../../../auth-user';
import { PaginatedResponse } from '../../../../common/types';
import { CreateUserDto, UpdateUserDto } from '../../dtos';
import { UserPhoto } from '../../entities/user-photo.entity';
import { User } from '../../entities/user.entity';

export interface IUsersService {
  create(dto: CreateUserDto): Promise<User>;

  confirm(nonConfirmedUser: User): Promise<User>;

  find(page: number, limit: number, active?: boolean, withDeleted?: boolean): Promise<PaginatedResponse<User> | User[]>;
  staticsUser(page: number, limit: number, withDeleted?: boolean): Promise<any[]>;

  findOne(id: string, withDeleted?: boolean): Promise<User>;

  updateMe(user: User, dto: UpdateUserDto): Promise<User>;

  updatePhone(user: User, dto: UpdateUserPhoneDto): Promise<User>;

  deleteMe(user: User): Promise<void>;

  getMyPhotos(user: User): Promise<UserPhoto[]>;

  update(id: string, dto: UpdateUserDto): Promise<User>;

  delete(id: string): Promise<void>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<User>;

  validate(id: string): Promise<User>;

  // recover(id: string): Promise<User>;
}
