// import { UpdatePhoneDto } from '../../../../auth-driver';
import { UpdateDriverPhoneDto } from '../../../../auth-driver';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles';
import { CreateDriverDto, UpdateDriverDto } from '../../dtos';
import { DriverPhoto } from '../../entities/driver-photo.entity';
import { Driver } from '../../entities/driver.entity';

export interface IDriversService {
  create(dto: CreateDriverDto, role: Role): Promise<Driver>;

  confirm(nonConfirmedDriver: Driver): Promise<Driver>;

  find(
    page: number,
    limit: number,
    withDeleted?: boolean,
  ): Promise<PaginatedResponse<Driver> | Driver[]>;

  findOne(id: string, withDeleted?: boolean): Promise<Driver>;

  updateMe(driver: Driver, dto: UpdateDriverDto): Promise<Driver>;

  updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver>;

  deleteMe(driver: Driver): Promise<void>;

  getMyPhotos(driver: Driver): Promise<DriverPhoto[]>;

  update(id: string, dto: UpdateDriverDto): Promise<Driver>;

  remove(id: string): Promise<void>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<Driver>;

  validate(id: string): Promise<Driver>;

  // addCar(carDto:CarDto,driver:Driver):Promise<Car>

  // recover(id: string): Promise<Driver>;
}
