import { UpdateDriverPhoneDto } from '../../../../auth-driver';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles';
import { CreateDriverDto, UpdateDriverDto } from '../../dtos';
import { DriverPhoto } from '../../entities/driver-photo.entity';
import { DriverWallet } from '../../entities/driver-wallet.entity';
import { Driver } from '../../entities/driver.entity';

export interface IDriverRepository {
  find(
    page: number,
    limit: number,
    withDeleted: boolean,
  ): Promise<PaginatedResponse<Driver> | Driver[]>;

  findOneById(id: string, withDeleted?: boolean): Promise<Driver>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<Driver>;

  findOneByIdForThings(id: string): Promise<Driver>;

  create(
    dto: CreateDriverDto,
    wallet: DriverWallet,
    photo: DriverPhoto,
    role: Role,
  ): Promise<Driver>;

  confirm(nonConfirmedDriver: Driver): Promise<Driver>;

  update(
    driver: Driver,
    dto: UpdateDriverDto,
    photo: DriverPhoto,
  ): Promise<Driver>;

  updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver>;

  // recover(driver: Driver): Promise<Driver>;

  remove(driver: Driver): Promise<void>;

  validate(id: string): Promise<Driver>;
}
