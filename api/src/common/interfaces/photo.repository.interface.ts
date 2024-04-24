import { IPhoto } from './photos.interface';

export interface IPhotoRepository<T> {
  create(params: IPhoto): T;
  uploadPhoto?(path: string): Promise<T>;
  uploadPhotoMulti?(paths: string[]): Promise<T[]>;
  findPhotosByOwner?(ownerId: string): Promise<T[]>;
  remove?(photo: T): Promise<void>;
}
