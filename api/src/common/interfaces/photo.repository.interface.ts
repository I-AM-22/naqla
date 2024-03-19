import { IPhoto } from './photos.interface';

export interface IPhotosRepository<T> {
  create(params: IPhoto): T;
  uploadPhoto(path: string): Promise<T>;
  findPhotosByOwner?(ownerId: string): Promise<T[]>;
  remove(photo: T): Promise<void>;
}
