import { IPhoto } from '../../../../common/interfaces';
import { DriverPhoto } from '../../entities/driver-photo.entity';

export interface IDriverPhotosRepository {
  create(params: IPhoto): DriverPhoto;
  uploadPhoto(path: string): Promise<DriverPhoto>;
  findPhotosByDriver(driverId: string): Promise<DriverPhoto[]>;
}
