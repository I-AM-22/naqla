import { Repository } from 'typeorm';
import { Entities } from '../enums';

export class BaseAuthRepo<Entity> {
  constructor(private readonly repository: Repository<Entity>) {}
  async validate(id: string): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');

    if (this.repository.metadata.name === Entities.User) {
      qb.where('entity.id = :id AND entity.active = :active', {
        id,
        active: true,
      });
      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    } else {
      qb.where('entity.id = :id', { id });
      qb.addSelect(['entity.passwordChangedAt']);
    }
    qb.select([
      'entity.id',
      'entity.firstName',
      'entity.lastName',
      'entity.phone',
      'entity.createdAt',
      'entity.updatedAt',
      'role.id',
      'role.name',
      'permissions.id',
      'permissions.action',
      'permissions.subject',
    ])
      .leftJoin('entity.role', 'role')
      .leftJoin('role.permissions', 'permissions')
      .leftJoinAndSelect('entity.photos', 'photos');

    const person = await qb.getOne();
    return person;
  }
  async findOneById(id: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');

    if (this.repository.metadata.name === Entities.User) {
      qb.where('entity.id = :id AND entity.active = :active', {
        id,
        active: true,
      });
      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    } else {
      qb.where('entity.id = :id', { id });
      qb.addSelect(['entity.passwordChangedAt', 'entity.password']);
    }

    qb.select([
      'entity.id',
      'entity.firstName',
      'entity.lastName',
      'entity.phone',
      'entity.createdAt',
      'entity.updatedAt',
      'role.id',
      'role.name',
      'permissions.id',
      'permissions.action',
      'permissions.subject',
    ])
      .leftJoin('entity.role', 'role')
      .leftJoin('role.permissions', 'permissions')
      .leftJoinAndSelect('entity.photos', 'photos');

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();

    return person;
  }

  async findOneByPhone(phone: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');

    if (this.repository.metadata.name === Entities.User) {
      qb.where('entity.phone = :phone AND entity.active = :active', {
        phone,
        active: true,
      });
      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    } else {
      qb.where('entity.phone = :phone', { phone });
      qb.addSelect(['entity.passwordChangedAt', 'entity.password']);
    }

    qb.select([
      'entity.id',
      'entity.firstName',
      'entity.lastName',
      'entity.phone',
      'entity.createdAt',
      'entity.updatedAt',
      'role.id',
      'role.name',
      'permissions.id',
      'permissions.action',
      'permissions.subject',
    ])
      .leftJoin('entity.role', 'role')
      .leftJoin('role.permissions', 'permissions')
      .leftJoinAndSelect('entity.photos', 'photos');

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();

    return person;
  }
}
