import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { IsNull, Not, Repository } from 'typeorm';
import { BaseAuthRepo } from '../../../../common/base';
import { IDriverRepository } from '../../interfaces/repositories/driver.repository.interface';
// import { UpdatePhoneDto } from '../../../auth-driver';
import { UpdateDriverPhoneDto } from '../../../../auth-driver';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles/entities/role.entity';
import { CreateDriverDto, UpdateDriverDto } from '../../dtos';
import { DriverPhoto } from '../../entities/driver-photo.entity';
import { DriverWallet } from '../../entities/driver-wallet.entity';
import { Driver } from '../../entities/driver.entity';

@Injectable()
export class DriverRepository extends BaseAuthRepo<Driver> implements IDriverRepository {
  constructor(@InjectRepository(Driver) private readonly driverRepo: Repository<Driver>) {
    super(driverRepo);
  }

  async find(
    page: number,
    limit: number,
    withActive: boolean,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<Driver>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || undefined;
    const data = await this.driverRepo.find({
      where: { active: true, disactiveAt: withActive ? IsNull() : Not(IsNull()) },
      relations: { photos: true, role: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.driverRepo.count({
      where: { active: true, disactiveAt: withActive ? IsNull() : Not(IsNull()) },
      withDeleted,
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async staticsDriver(page: number, limit: number, withDeleted: boolean): Promise<PaginatedResponse<Driver>> {
    const skip = (page - 1) * limit || 0;
    const take = limit || 100;
    const data = await this.driverRepo.find({
      where: { active: true, disactiveAt: IsNull() },
      relations: { photos: true, wallet: true },
      skip,
      take,
      withDeleted,
    });
    const totalDataCount = await this.driverRepo.count({
      where: { active: true, disactiveAt: IsNull() },
      withDeleted,
    });
    return PaginatedResponse.pagination(page, limit, totalDataCount, data);
  }

  async countDriver(): Promise<number> {
    const driverCount = await this.driverRepo.find({ where: { active: true, disactiveAt: IsNull() } });
    return driverCount.length;
  }

  async create(dto: CreateDriverDto, wallet: DriverWallet, photo: DriverPhoto, role: Role): Promise<Driver> {
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
  async updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver> {
    Object.assign(driver, dto);
    await this.driverRepo.save(driver);
    return this.findById(driver.id);
  }

  async update(driver: Driver, dto: UpdateDriverDto, photo: DriverPhoto): Promise<Driver> {
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

  async delete(id: string): Promise<void> {
    await this.driverRepo.softDelete({ id });
  }

  async deactivate(id: string): Promise<void> {
    await this.driverRepo.update({ id }, { disactiveAt: new Date() });
  }
}
