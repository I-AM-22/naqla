import { PaginatedResponse } from '../types';

export interface ICrud<T> {
  create(...n): Promise<T>;
  find(...n): Promise<T[] | PaginatedResponse<T>>;
  findOne(...n): Promise<T>;
  update(...n): Promise<T>;
  delete(...n): Promise<any>;
}

export interface INestedController<T> {
  create(...n): Promise<T>;
  find(...n): Promise<T[] | PaginatedResponse<T>>;
}

export interface IGenericController<T> {
  findOne(...n): Promise<T>;
  update(...n): Promise<T>;
  delete(...n): Promise<void>;
}
