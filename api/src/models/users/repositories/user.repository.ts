import { BaseAuthRepo } from '@common/base';
import { PaginatedResponse } from '@common/types';
import { Role } from '@models/roles/entities/role.entity';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IsNull, Not, Repository } from 'typeorm';
import { UpdateUserPhoneDto } from '../../../auth-user';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { UserPhoto } from '../entities/user-photo.entity';
import { UserWallet } from '../entities/user-wallet.entity';
import { User } from '../entities/user.entity';
import { IUserRepository } from '../interfaces/repositories/user.repository.interface';

@Injectable()
export class UserRepository extends BaseAuthRepo<User> implements IUserRepository {
  constructor(@InjectRepository(User) private readonly userRepo: Repository<User>) {
    super(userRepo);
  }

  async find(page: number, limit: number, withActive: boolean, withDeleted: boolean): Promise<PaginatedResponse<User>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || undefined;
    const data = await this.userRepo.find({
      where: { active: true, disactiveAt: withActive ? IsNull() : Not(IsNull()) },
      relations: { photos: true, role: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.userRepo.count({
      where: { active: true, disactiveAt: withActive ? IsNull() : Not(IsNull()) },
      withDeleted,
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async findByIdForDelete(id: string): Promise<User> {
    return await this.userRepo.findOne({
      where: { id, active: true },

      relations: {
        photos: true,
        wallet: true,
        orders: { subOrders: { messages: true }, photos: true, payment: true },
      },
    });
  }

  async staticsUser(page: number, limit: number, withDeleted: boolean): Promise<PaginatedResponse<User>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.userRepo.find({
      where: { active: true, disactiveAt: IsNull() },
      relations: { photos: true, wallet: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.userRepo.count({
      where: { active: true, disactiveAt: IsNull() },
      withDeleted,
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async countUser(): Promise<number> {
    const userCount = await this.userRepo.find({ where: { active: true, disactiveAt: IsNull() } });
    return userCount.length;
  }

  async create(dto: CreateUserDto, wallet: UserWallet, photo: UserPhoto, role: Role): Promise<User> {
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

  async update(user: User, dto: UpdateUserDto, photo: UserPhoto): Promise<User> {
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

  async delete(id: string): Promise<void> {
    await this.userRepo.softDelete({ id });
  }

  async deactivate(id: string): Promise<void> {
    await this.userRepo.update({ id }, { disactiveAt: new Date() });
  }
}
