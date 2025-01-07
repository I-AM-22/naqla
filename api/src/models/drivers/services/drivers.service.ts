import { BadRequestException, Inject, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { CreateDriverDto, UpdateDriverDto } from '../dtos';
import { Driver } from '../entities/driver.entity';
import { Entities, ORDER_STATUS, ROLE, SUB_ORDER_STATUS } from '@common/enums';
import { defaultPhotoUrl, item_not_found } from '@common/constants';
import { PaginatedResponse } from '@common/types';
import { DriverPhoto } from '../entities/driver-photo.entity';
import { IDriverRepository } from '../interfaces/repositories/driver.repository.interface';
import { DRIVER_TYPES } from '../interfaces/type';
import { UpdateDriverPhoneDto } from '../../../auth-driver';
import { IPhotoRepository, IWalletRepository } from '@common/interfaces';
import { DriverWallet } from '../entities/driver-wallet.entity';
import { Rating } from '@models/sub-orders/interfaces/rating';
import { In } from 'typeorm';
import { RolesService } from '@models/roles/services/roles.service';
import { SubOrdersService } from '@models/sub-orders/services/sub-orders.service';

@Injectable()
export class DriversService {
  constructor(
    @Inject(DRIVER_TYPES.repository.driver)
    private driverRepository: IDriverRepository,
    @Inject(DRIVER_TYPES.repository.wallet)
    private driverWalletRepository: IWalletRepository<DriverWallet>,
    @Inject(DRIVER_TYPES.repository.photo)
    private driverPhotoRepository: IPhotoRepository<DriverPhoto>,
    private rolesService: RolesService,
    private subOrdersService: SubOrdersService,
  ) {}

  async create(dto: CreateDriverDto): Promise<Driver> {
    const role = await this.rolesService.findByName(ROLE.DRIVER);
    let photo;
    if (dto.photo) photo = await this.driverPhotoRepository.uploadPhoto(dto.photo);
    else photo = await this.driverPhotoRepository.uploadPhoto(defaultPhotoUrl);
    const wallet = this.driverWalletRepository.create();
    return this.driverRepository.create(dto, wallet, photo, role);
  }

  async find(
    page: number,
    limit: number,
    active: boolean = true,
    withDeleted: boolean = false,
  ): Promise<PaginatedResponse<Driver> | Driver[]> {
    return this.driverRepository.find(page, limit, active, withDeleted);
  }

  async findOne(id: string, withDeleted = false): Promise<Driver> {
    const driver = await this.driverRepository.findById(id, withDeleted);
    if (!driver) throw new NotFoundException(item_not_found(Entities.Driver));
    return driver;
  }

  async findOneByPhone(id: string, withDeleted?: boolean): Promise<Driver> {
    const driver = await this.driverRepository.findOneByPhone(id, withDeleted);
    return driver;
  }

  async updateMe(driver: Driver, dto: UpdateDriverDto): Promise<Driver> {
    const photo = await this.driverPhotoRepository.uploadPhoto(dto.photo);
    const updateDriver = await this.driverRepository.update(driver, dto, photo);
    return updateDriver;
  }

  async deleteMe(driver: Driver): Promise<void> {
    const subOrders = await this.subOrdersService.findBy({
      order: { status: ORDER_STATUS.ON_THE_WAY },
      car: { driverId: driver.id },
    });

    if (subOrders.length) {
      throw new BadRequestException('Can not remove a driver who has an active orders');
    }

    await this.driverRepository.deactivate(driver.id);
  }

  async getMyPhotos(driver: Driver): Promise<DriverPhoto[]> {
    return this.driverPhotoRepository.findPhotosByOwner(driver.id);
  }

  async update(id: string, dto: UpdateDriverDto): Promise<Driver> {
    const driver = await this.findOne(id);
    const photo = await this.driverPhotoRepository.uploadPhoto(dto.photo);
    const updateDriver = await this.driverRepository.update(driver, dto, photo);
    return updateDriver;
  }

  async updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver> {
    return this.driverRepository.updatePhone(driver, dto);
  }

  confirm(nonConfirmedDriver: Driver): Promise<Driver> {
    return this.driverRepository.confirm(nonConfirmedDriver);
  }

  async delete(id: string): Promise<void> {
    await this.findOne(id);

    const subOrders = await this.subOrdersService.findBy({
      status: In([SUB_ORDER_STATUS.TAKEN, SUB_ORDER_STATUS.ON_THE_WAY]),
      car: { driverId: id },
    });

    if (subOrders.length) {
      throw new BadRequestException('Can not remove a driver who has an active orders');
    }

    await this.driverRepository.deactivate(id);
  }

  async validate(id: string): Promise<Driver> {
    const driver = await this.driverRepository.validate(id);
    if (!driver) {
      throw new UnauthorizedException('The driver is not here');
    }
    return driver;
  }

  allratingForDriver(id: string): Promise<Rating[]> {
    return this.subOrdersService.allratingForDriver(id);
  }
}
