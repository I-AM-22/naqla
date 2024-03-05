import { Role } from '../../roles';
import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CreateUserDto, UpdateUserDto, User, UserPhoto } from '..';
import { InjectRepository } from '@nestjs/typeorm';
import { IUserRepository } from '../interfaces/repositories/user.repository.interface';
import { IUserPhotosRepository } from '../interfaces/repositories/user-photos.repository.interface';
import { USER_TYPES } from '../interfaces/type';
import { IWalletRepository } from '../interfaces/repositories/wallet.repository.interface';
import { BaseAuthRepo } from '../../../common/entities';
import { defaultPhotoUrl } from '../../../common/constants';
import { UpdatePhoneDto } from '../../../auth-user';
import { pagination } from '../../../common/helpers';
import { PaginatedResponse } from '../../../common/types';

@Injectable()
export class UserRepository
  extends BaseAuthRepo<User>
  implements IUserRepository
{
  constructor(
    @InjectRepository(User) private readonly userRepo: Repository<User>,
    @Inject(USER_TYPES.repository.user_photos)
    private readonly userPhotosRepository: IUserPhotosRepository,
    @Inject(USER_TYPES.repository.wallet)
    private readonly walletRepository: IWalletRepository,
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

  async create(dto: CreateUserDto, role: Role): Promise<User> {
    const wallet = this.walletRepository.create();
    const photo = await this.userPhotosRepository.uploadPhoto(defaultPhotoUrl);
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
    return this.findOneById(nonConfirmedUser.id);
  }

  async updatePhone(user: User, dto: UpdatePhoneDto): Promise<User> {
    Object.assign(user, dto);
    await this.userRepo.save(user);
    return this.findOneById(user.id);
  }

  async update(user: User, dto: UpdateUserDto): Promise<User> {
    user.photos.push(await this.userPhotosRepository.uploadPhoto(dto.photo));
    Object.assign(user, {
      firstName: dto.firstName,
      lastName: dto.lastName,
    });
    await this.userRepo.save(user);
    return this.findOneById(user.id);
  }

  async findOneByIdForThings(id: string): Promise<User> {
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

  async getMyPhotos(userId: string): Promise<UserPhoto[]> {
    return this.userPhotosRepository.findPhotosByUser(userId);
  }

  // async recover(user: User): Promise<User> {
  //   return this.userRepo.recover(user);
  // }
  async remove(user: User): Promise<void> {
    this.userRepo.softRemove(user);
  }
}
