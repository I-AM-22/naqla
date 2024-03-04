import { ConfirmDto, UpdatePhoneDto } from '../../../../auth-user';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles';
import { CreateUserDto, UpdateUserDto } from '../../dtos';
import { UserPhoto } from '../../entities/user-photo.entity';
import { User } from '../../entities/user.entity';

export interface IUserRepository {
  find(
    page: number,
    limit: number,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<User> | User[]>;

  findOneById(id: string, withDeleted: boolean): Promise<User>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<User>;

  findOneForConfirm(dto: ConfirmDto, phoneConfirm: boolean): Promise<User>;

  findOneByIdForThings(id: string): Promise<User>;

  create(dto: CreateUserDto, role: Role): Promise<User>;

  confirm(nonConfirmedUser: User, phoneConfirm: boolean): Promise<User>;

  createOtp(user: User, update?: boolean): Promise<void>;

  update(user: User, dto: UpdateUserDto): Promise<User>;

  getMyPhotos(userId: string): Promise<UserPhoto[]>;

  updatePhone(user: User, dto: UpdatePhoneDto): Promise<void>;

  // recover(user: User): Promise<User>;

  remove(user: User): Promise<void>;

  validate(id: string): Promise<User>;
}
