import { Permission } from '../../entities/permission.entity';

export interface IPermissionsService {
  find(permissionsIds?: string[]): Promise<Permission[]>;

  findOne(id: string, withDeleted?: boolean): Promise<Permission>;
}
