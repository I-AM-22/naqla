import { Role } from '@models/roles/entities/role.entity';
import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { IUserRepository } from '../interfaces/repositories/user.repository.interface';
import { BaseAuthRepo } from '@common/base';
import { pagination } from '@common/helpers';
import { PaginatedResponse } from '@common/types';
import { UpdateUserPhoneDto } from '../../../auth-user';
import { UserWallet } from '../entities/user-wallet.entity';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { UserPhoto } from '../entities/user-photo.entity';
import { User } from '../entities/user.entity';

@Injectable()
export class UserRepository
  extends BaseAuthRepo<User>
  implements IUserRepository
{
  constructor(
    @InjectRepository(User) private readonly userRepo: Repository<User>,
  ) {
    super(userRepo);
  }

  async find(
    page: number,
    limit: number,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<User>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.userRepo.find({
      where: { active: true },
      relations: { photos: true, role: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.userRepo.count({ withDeleted });
    return pagination(page, limit, totalDataCount, data);
  }

  async create(
    dto: CreateUserDto,
    wallet: UserWallet,
    photo: UserPhoto,
    role: Role,
  ): Promise<User> {
    const user = this.userRepo.create({
      ...dto,
      role,
      wallet,
      photos: [photo],
    });
    await this.userRepo.save(user);
    return this.findOneByPhone(user.phone);
  }

  async confirm(nonConfirmedUser: User): Promise<User> {
    nonConfirmedUser.active = true;
    await this.userRepo.save(nonConfirmedUser);
    return this.findById(nonConfirmedUser.id);
  }

  async updatePhone(user: User, dto: UpdateUserPhoneDto): Promise<User> {
    Object.assign(user, dto);
    await this.userRepo.save(user);
    return this.findById(user.id);
  }

  async update(
    user: User,
    dto: UpdateUserDto,
    photo: UserPhoto,
  ): Promise<User> {
    user.photos.push(photo);
    Object.assign(user, {
      firstName: dto.firstName,
      lastName: dto.lastName,
    });
    await this.userRepo.save(user);
    return this.findById(user.id);
  }

  async findByIdForThings(id: string): Promise<User> {
    return await this.userRepo.findOne({
      where: { id, active: true },
      select: {
        id: true,
        firstName: true,
        lastName: true,
      },
      relations: { photos: true },
    });
  }

  // async recover(user: User): Promise<User> {
  //   return this.userRepo.recover(user);
  // }
  async remove(user: User): Promise<void> {
    this.userRepo.softRemove(user);
  }
}
