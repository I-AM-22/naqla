import {
  Inject,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { CreateDriverDto, UpdateDriverDto } from '../dtos';
import { Driver } from '../entities/driver.entity';
import { Entities } from '../../../common/enums';
import { item_not_found } from '../../../common/constants';
import { ICitiesService } from '../../cities/interfaces/services/cities.service.interface';
import { CITY_TYPES } from '../../cities/interfaces/type';
import { IDriversService } from '../interfaces/services/drivers.service.interface';
import { PaginatedResponse } from '../../../common/types';
import { DriverPhoto } from '../entities/driver-photo.entity';
import { IDriverRepository } from '../interfaces/repositories/driver.repository.interface';
import { DRIVER_TYPES } from '../interfaces/type';
import { Role } from '../../roles';
import { UpdateDriverPhoneDto } from '../../../auth-driver';
// import { UpdatePhoneDto } from '../../../auth-driver';

@Injectable()
export class DriversService implements IDriversService {
  constructor(
    @Inject(DRIVER_TYPES.repository.driver)
    private driverRepository: IDriverRepository,

    @Inject(CITY_TYPES.service) private citiesService: ICitiesService,
  ) {}

  create(dto: CreateDriverDto, role: Role): Promise<Driver> {
    return this.driverRepository.create(dto, role);
  }

  async find(
    page: number,
    limit: number,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<Driver> | Driver[]> {
    return this.driverRepository.find(page, limit, withDeleted);
  }

  async findOne(id: string, withDeleted = false): Promise<Driver> {
    const driver = await this.driverRepository.findOneById(id, withDeleted);
    if (!driver) throw new NotFoundException(item_not_found(Entities.Driver));
    return driver;
  }

  async findOneByPhone(id: string, withDeleted?: boolean): Promise<Driver> {
    const driver = await this.driverRepository.findOneByPhone(id, withDeleted);
    return driver;
  }

  async updateMe(dto: UpdateDriverDto, driver: Driver): Promise<Driver> {
    const updateDriver = await this.driverRepository.update(driver, dto);
    return updateDriver;
  }

  async deleteMe(driver: Driver): Promise<void> {
    await this.driverRepository.remove(driver);
  }
  async getMyPhotos(driver: Driver): Promise<DriverPhoto[]> {
    return this.driverRepository.getMyPhotos(driver.id);
  }

  async update(id: string, dto: UpdateDriverDto): Promise<Driver> {
    const driver = await this.findOne(id);
    const updateDriver = await this.driverRepository.update(driver, dto);
    return updateDriver;
  }

  //TODO
  async updatePhone(
    driver: Driver,
    dto: UpdateDriverPhoneDto,
  ): Promise<Driver> {
    return this.driverRepository.updatePhone(driver, dto);
  }

  // async recover(id: string): Promise<Driver> {
  //   const driver = await this.findOne(id, true);
  //   if (!driver) throw new NotFoundException(item_not_found(Entities.Driver));
  //   await this.driverRepository.recover(driver);
  //   return driver;
  // }

  confirm(nonConfirmedDriver: Driver): Promise<Driver> {
    return this.driverRepository.confirm(nonConfirmedDriver);
  }

  async remove(id: string): Promise<void> {
    const driver = await this.findOne(id);
    await this.driverRepository.remove(driver);
    return;
  }

  async validate(id: string): Promise<Driver> {
    const driver = await this.driverRepository.findOneById(id);
    if (!driver) {
      throw new UnauthorizedException('The driver is not here');
    }
    return driver;
  }
}
