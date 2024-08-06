import { UpdateDriverPhoneDto } from '../../../../auth-driver';
import { PaginatedResponse } from '../../../../common/types';
import { Role } from '../../../roles/entities/role.entity';
import { CreateDriverDto, UpdateDriverDto } from '../../dtos';
import { DriverPhoto } from '../../entities/driver-photo.entity';
import { DriverWallet } from '../../entities/driver-wallet.entity';
import { Driver } from '../../entities/driver.entity';

export interface IDriverRepository {
  find(
    page: number,
    limit: number,
    withActive?: boolean,
    withDeleted?: boolean,
  ): Promise<PaginatedResponse<Driver> | Driver[]>;
  staticsDriver(page: number, limit: number, withDeleted: boolean): Promise<PaginatedResponse<Driver>>;
  findById(id: string, withDeleted?: boolean): Promise<Driver>;

  findOneByPhone(phone: string, withDeleted?: boolean): Promise<Driver>;

  findByIdForThings(id: string): Promise<Driver>;

  countDriver(): Promise<number>;

  create(dto: CreateDriverDto, wallet: DriverWallet, photo: DriverPhoto, role: Role): Promise<Driver>;

  confirm(nonConfirmedDriver: Driver): Promise<Driver>;

  update(driver: Driver, dto: UpdateDriverDto, photo: DriverPhoto): Promise<Driver>;

  updatePhone(driver: Driver, dto: UpdateDriverPhoneDto): Promise<Driver>;

  delete(id: string): Promise<void>;

  deactivate(id: string): Promise<void>;

  validate(id: string): Promise<Driver>;
}
