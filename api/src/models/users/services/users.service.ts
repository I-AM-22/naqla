import { BadRequestException, Inject, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { CreateUserDto, UpdateUserDto } from '../dtos';
import { User } from '../entities/user.entity';
import { defaultPhotoUrl, item_not_found } from '@common/constants';
import { PaginatedResponse } from '@common/types';
import { UserPhoto } from '../entities/user-photo.entity';
import { IUserRepository } from '../interfaces/repositories/user.repository.interface';
import { USER_TYPES } from '../interfaces/type';
import { UpdateUserPhoneDto } from '../../../auth-user';
import { IPhotoRepository, IWalletRepository } from '@common/interfaces';
import { UserWallet } from '../entities/user-wallet.entity';
import { Entities, ORDER_STATUS, ROLE } from '@common/enums';
import { In } from 'typeorm';
import { RolesService } from '@models/roles/services/roles.service';
import { SubOrdersService } from '@models/sub-orders/services/sub-orders.service';

@Injectable()
export class UsersService {
  constructor(
    @Inject(USER_TYPES.repository.user)
    private userRepository: IUserRepository,
    @Inject(USER_TYPES.repository.photo)
    private userPhotoRepository: IPhotoRepository<UserPhoto>,
    @Inject(USER_TYPES.repository.wallet)
    private userWalletRepository: IWalletRepository<UserWallet>,
    private rolesService: RolesService,
    private subOrdersService: SubOrdersService,
  ) {}

  async create(dto: CreateUserDto): Promise<User> {
    const role = await this.rolesService.findByName(ROLE.USER);
    let photo;
    if (dto.photo) photo = await this.userPhotoRepository.uploadPhoto(dto.photo);
    else photo = await this.userPhotoRepository.uploadPhoto(defaultPhotoUrl);
    const wallet = this.userWalletRepository.create();
    return this.userRepository.create(dto, wallet, photo, role);
  }

  async find(
    page: number,
    limit: number,
    active: boolean = true,
    withDeleted: boolean = true,
  ): Promise<PaginatedResponse<User> | User[]> {
    return this.userRepository.find(page, limit, active, withDeleted);
  }

  async findOne(id: string, withDeleted = false): Promise<User> {
    const user = await this.userRepository.findById(id, withDeleted);
    if (!user) throw new NotFoundException(item_not_found(Entities.User));
    return user;
  }

  async findOneByPhone(id: string, withDeleted?: boolean): Promise<User> {
    const user = await this.userRepository.findOneByPhone(id, withDeleted);
    return user;
  }

  async updateMe(user: User, dto: UpdateUserDto): Promise<User> {
    const photo = await this.userPhotoRepository.uploadPhoto(dto.photo);
    const updateUser = await this.userRepository.update(user, dto, photo);
    return updateUser;
  }

  async deleteMe(user: User): Promise<void> {
    const subOrders = await this.subOrdersService.findBy({
      order: { userId: user.id, status: ORDER_STATUS.ON_THE_WAY },
    });

    if (subOrders.length) {
      throw new BadRequestException('Can not remove a user who has an active orders');
    }

    await this.userRepository.deactivate(user.id);
  }

  async getMyPhotos(user: User): Promise<UserPhoto[]> {
    return this.userPhotoRepository.findPhotosByOwner(user.id);
  }

  async update(id: string, dto: UpdateUserDto): Promise<User> {
    const user = await this.findOne(id);
    const photo = await this.userPhotoRepository.uploadPhoto(dto.photo);
    const updateUser = await this.userRepository.update(user, dto, photo);
    return updateUser;
  }

  async updatePhone(user: User, dto: UpdateUserPhoneDto): Promise<User> {
    return this.userRepository.updatePhone(user, dto);
  }

  confirm(nonConfirmedUser: User): Promise<User> {
    return this.userRepository.confirm(nonConfirmedUser);
  }

  async delete(id: string): Promise<void> {
    await this.findOne(id);
    const subOrders = await this.subOrdersService.findBy({
      order: { userId: id, status: In([ORDER_STATUS.ACCEPTED, ORDER_STATUS.ON_THE_WAY, ORDER_STATUS.READY]) },
    });
    console.log(subOrders);
    if (subOrders.length) {
      throw new BadRequestException('Can not remove a user who has an active orders');
    }

    await this.userRepository.deactivate(id);
  }

  async validate(id: string): Promise<User> {
    const user = await this.userRepository.validate(id);
    if (!user) {
      throw new UnauthorizedException('The user is not here');
    }
    return user;
  }
}
