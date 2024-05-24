import { Role } from '../../../roles';
import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { CreateDriverDto, UpdateDriverDto, Driver, DriverPhoto } from '../..';
import { InjectRepository } from '@nestjs/typeorm';
import { IDriverRepository } from '../../interfaces/repositories/driver.repository.interface';
import { BaseAuthRepo } from '../../../../common/base';
// import { UpdatePhoneDto } from '../../../auth-driver';
import { pagination } from '../../../../common/helpers';
import { PaginatedResponse } from '../../../../common/types';
import { UpdateDriverPhoneDto } from '../../../../auth-driver';
import { DriverWallet } from '../../entities/driver-wallet.entity';

@Injectable()
export class DriverRepository
  extends BaseAuthRepo<Driver>
  implements IDriverRepository
{
  constructor(
    @InjectRepository(Driver) private readonly driverRepo: Repository<Driver>,
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

  async create(
    dto: CreateDriverDto,
    wallet: DriverWallet,
    photo: DriverPhoto,
    role: Role,
  ): Promise<Driver> {
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
    return this.findById(nonConfirmedDriver.id);
  }

  //TODO
  async updatePhone(
    driver: Driver,
    dto: UpdateDriverPhoneDto,
  ): Promise<Driver> {
    Object.assign(driver, dto);
    await this.driverRepo.save(driver);
    return this.findById(driver.id);
  }

  async update(
    driver: Driver,
    dto: UpdateDriverDto,
    photo: DriverPhoto,
  ): Promise<Driver> {
    driver.photos.push(photo);
    Object.assign(driver, {
      firstName: dto.firstName,
      lastName: dto.lastName,
    });
    await this.driverRepo.save(driver);
    return this.findById(driver.id);
  }

  async findByIdForThings(id: string): Promise<Driver> {
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

  // async recover(driver: Driver): Promise<Driver> {
  //   return this.driverRepo.recover(driver);
  // }
  async remove(driver: Driver): Promise<void> {
    this.driverRepo.softRemove(driver);
  }
}
