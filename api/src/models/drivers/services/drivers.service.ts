import { Inject, Injectable, NotFoundException, UnauthorizedException } from '@nestjs/common';
import { CreateDriverDto, UpdateDriverDto } from '../dtos';
import { Driver } from '../entities/driver.entity';
import { Entities, ROLE } from '@common/enums';
import { defaultPhotoUrl, item_not_found } from '@common/constants';
import { IDriversService } from '../interfaces/services/drivers.service.interface';
import { PaginatedResponse } from '@common/types';
import { DriverPhoto } from '../entities/driver-photo.entity';
import { IDriverRepository } from '../interfaces/repositories/driver.repository.interface';
import { DRIVER_TYPES } from '../interfaces/type';
import { UpdateDriverPhoneDto } from '../../../auth-driver';
import { ROLE_TYPES } from '@models/roles/interfaces/type';
import { IRolesService } from '@models/roles/interfaces/services/roles.service.interface';
// import { UpdatePhoneDto } from '../../../auth-driver';
import { IPhotoRepository, IWalletRepository } from '@common/interfaces';
import { DriverWallet } from '../entities/driver-wallet.entity';
import { ISubOrdersService } from '@models/sub-orders/interfaces/services/sub-orders.service.interface';
import { SUB_ORDER_TYPES } from '@models/sub-orders/interfaces/type';
import { ICarsService } from '@models/cars/interfaces/services/cars.service.interface';
import { CAR_TYPES } from '@models/cars/interfaces/type';

@Injectable()
export class DriversService implements IDriversService {
  constructor(
    @Inject(DRIVER_TYPES.repository.driver)
    private driverRepository: IDriverRepository,
    @Inject(DRIVER_TYPES.repository.wallet)
    private driverWalletRepository: IWalletRepository<DriverWallet>,
    @Inject(DRIVER_TYPES.repository.photo)
    private driverPhotoRepository: IPhotoRepository<DriverPhoto>,
    @Inject(ROLE_TYPES.service) private rolesService: IRolesService,
    @Inject(SUB_ORDER_TYPES.service)
    private subOrderService: ISubOrdersService,
    @Inject(CAR_TYPES.service)
    private carsService: ICarsService,
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

  async staticsDriver(page: number, limit: number, withDeleted: boolean): Promise<any[]> {
    const data = await this.driverRepository.staticsDriver(page, limit, withDeleted);
    const updateDriver = await Promise.all(
      data.data.map(async (driver) => {
        const countOrderDelivered = await this.subOrderService.countSubOrdersCompletedForDriver(driver.id);
        const countCar = await this.carsService.countCarForDriver(driver.id);
        return {
          ...driver,
          countOrderDelivered,
          countCar,
        };
      }),
    );
    return updateDriver;
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
    const toDelete = await this.driverRepository.findByIdForDelete(driver.id);
    await this.driverRepository.delete(toDelete);
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

  //TODO
  async updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver> {
    return this.driverRepository.updatePhone(driver, dto);
  }

  confirm(nonConfirmedDriver: Driver): Promise<Driver> {
    return this.driverRepository.confirm(nonConfirmedDriver);
  }

  async delete(id: string): Promise<void> {
    // const driver = await this.driverRepository.findByIdForDelete(id);
    // await this.driverRepository.delete(driver);
    await this.driverRepository.deactivate(id);
    return;
  }

  async validate(id: string): Promise<Driver> {
    const driver = await this.driverRepository.validate(id);
    if (!driver) {
      throw new UnauthorizedException('The driver is not here');
    }
    return driver;
  }
}
