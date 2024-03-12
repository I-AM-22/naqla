import { Role } from '../../roles';
import { Inject, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CreateDriverDto, UpdateDriverDto, Driver, DriverPhoto } from '..';
import { InjectRepository } from '@nestjs/typeorm';
import { IDriverRepository } from '../interfaces/repositories/driver.repository.interface';
import { IDriverPhotosRepository } from '../interfaces/repositories/driver-photos.repository.interface';
import { DRIVER_TYPES } from '../interfaces/type';
import { IWalletDriverRepository } from '../interfaces/repositories/driver-wallet.repository.interface';
import { BaseAuthRepo } from '../../../common/base';
import { defaultPhotoUrl } from '../../../common/constants';
// import { UpdatePhoneDto } from '../../../auth-driver';
import { pagination } from '../../../common/helpers';
import { PaginatedResponse } from '../../../common/types';
import { UpdateDriverPhoneDto } from '../../../auth-driver';

@Injectable()
export class DriverRepository
  extends BaseAuthRepo<Driver>
  implements IDriverRepository
{
  constructor(
    @InjectRepository(Driver) private readonly driverRepo: Repository<Driver>,
    @Inject(DRIVER_TYPES.repository.driver_photos)
    private readonly driverPhotosRepository: IDriverPhotosRepository,
    @Inject(DRIVER_TYPES.repository.wallet)
    private readonly walletDriverRepository: IWalletDriverRepository,
  ) {
    super(driverRepo);
  }

  async find(
    page: number,
    limit: number,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<Driver>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.driverRepo.find({
      where: { active: true },
      relations: { photos: true, role: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.driverRepo.count({ withDeleted });
    return pagination(page, limit, totalDataCount, data);
  }

  async create(dto: CreateDriverDto, role: Role): Promise<Driver> {
    const wallet = this.walletDriverRepository.create();
    const photo =
      await this.driverPhotosRepository.uploadPhoto(defaultPhotoUrl);
    const driver = this.driverRepo.create({
      ...dto,
      role,
      wallet,
      photos: [photo],
    });
    await this.driverRepo.save(driver);
    return this.findOneByPhone(driver.phone);
  }

  async confirm(nonConfirmedDriver: Driver): Promise<Driver> {
    nonConfirmedDriver.active = true;
    await this.driverRepo.save(nonConfirmedDriver);
    return this.findOneById(nonConfirmedDriver.id);
  }

  //TODO
  async updatePhone(
    driver: Driver,
    dto: UpdateDriverPhoneDto,
  ): Promise<Driver> {
    Object.assign(driver, dto);
    await this.driverRepo.save(driver);
    return this.findOneById(driver.id);
  }

  async update(driver: Driver, dto: UpdateDriverDto): Promise<Driver> {
    driver.photos.push(
      await this.driverPhotosRepository.uploadPhoto(dto.photo),
    );
    Object.assign(driver, {
      firstName: dto.firstName,
      lastName: dto.lastName,
    });
    await this.driverRepo.save(driver);
    return this.findOneById(driver.id);
  }

  async findOneByIdForThings(id: string): Promise<Driver> {
    return await this.driverRepo.findOne({
      where: { id, active: true },
      select: {
        id: true,
        firstName: true,
        lastName: true,
      },
      relations: { photos: true },
    });
  }

  async getMyPhotos(driverId: string): Promise<DriverPhoto[]> {
    return this.driverPhotosRepository.findPhotosByDriver(driverId);
  }

  // async recover(driver: Driver): Promise<Driver> {
  //   return this.driverRepo.recover(driver);
  // }
  async remove(driver: Driver): Promise<void> {
    this.driverRepo.softRemove(driver);
  }
}
