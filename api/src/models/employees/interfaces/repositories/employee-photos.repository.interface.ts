import { IPhoto } from '../../../../common/interfaces';
import { EmployeePhoto } from '../../entities/employee-photo.entity';

export interface IEmployeePhotosRepository {
  create(params: IPhoto): EmployeePhoto;
  uploadPhoto(path: string): Promise<EmployeePhoto>;
}
