export interface IPhotoRepository<T> {
  find(productId: string): Promise<T[]>;
  findOne(id: string, relations?: string[]): Promise<T>;
  remove(photo: T): Promise<void>;
  uploadPhotos(paths: string[]): Promise<T[]>;
}
