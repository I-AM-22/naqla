import { IPhoto } from '../../../../common/interfaces';
import { AdminPhoto } from '../../entities/admin-photo.entity';

export interface IAdminPhotosRepository {
  create(params: IPhoto): AdminPhoto;
  uploadPhoto(path: string): Promise<AdminPhoto>;
}
