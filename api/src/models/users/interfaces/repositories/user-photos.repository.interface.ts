import { IPhoto } from '../../../../common/interfaces';
import { UserPhoto } from '../../entities/user-photo.entity';

export interface IUserPhotosRepository {
  create(params: IPhoto): UserPhoto;
  uploadPhoto(path: string): Promise<UserPhoto>;
  findPhotosByUser(userId: string): Promise<UserPhoto[]>;
}
