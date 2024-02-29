import { Repository } from 'typeorm';
import { Entities } from '../enums';

export class BaseAuthRepo<Entity> {
  constructor(private readonly repository: Repository<Entity>) {}
  async validate(id: string): Promise<Entity> {
    const qb = this.repository
      .createQueryBuilder('entity')
      .where('entity.id = :id', { id })
      .select([
        'entity.id',
        'entity.firstName',
        'entity.lastName',
        'entity.phone',
        'entity.passwordChangedAt',
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
    if (this.repository.metadata.name === Entities.User) {
      qb.leftJoin('entity.wallet', 'wallet');

      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    }

    const person = await qb.getOne();
    return person;
  }
  async findOneById(id: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository
      .createQueryBuilder('entity')
      .where('entity.id = :id', { id })
      .select([
        'entity.id',
        'entity.firstName',
        'entity.lastName',
        'entity.phone',
        'entity.passwordChangedAt',
        'entity.createdAt',
        'entity.updatedAt',
        'entity.password',
        'role.id',
        'role.name',
        'permissions.id',
        'permissions.action',
        'permissions.subject',
      ])
      .leftJoin('entity.role', 'role')
      .leftJoin('role.permissions', 'permissions')
      .leftJoinAndSelect('entity.photos', 'photos');

    if (this.repository.metadata.name === Entities.User) {
      qb.leftJoin('entity.wallet', 'wallet');

      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    }

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();

    return person;
  }

  async findOneByPhone(phone: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository
      .createQueryBuilder('entity')
      .where('entity.phone = :phone', { phone })
      .select([
        'entity.id',
        'entity.firstName',
        'entity.lastName',
        'entity.phone',
        'entity.passwordChangedAt',
        'entity.createdAt',
        'entity.updatedAt',
        'entity.password',
        'role.id',
        'role.name',
        'permissions.id',
        'permissions.action',
        'permissions.subject',
      ])
      .leftJoin('entity.role', 'role')
      .leftJoin('role.permissions', 'permissions')
      .leftJoinAndSelect('entity.photos', 'photos');

    if (this.repository.metadata.name === Entities.User) {
      qb.leftJoin('entity.wallet', 'wallet');

      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending']);
    }

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();

    return person;
  }
}
