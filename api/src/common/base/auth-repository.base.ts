import { Repository } from 'typeorm';
import { Entities } from '../enums';

export class BaseAuthRepo<Entity> {
  constructor(private readonly repository: Repository<Entity>) {}
  async validate(id: string): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');
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

    if (this.repository.metadata.name === Entities.User || this.repository.metadata.name === Entities.Driver) {
      qb.where('entity.id = :id AND entity.active = :active AND entity.disactiveAt IS NULL', {
        id,
        active: true,
      });

      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect([
        'wallet.id',
        'wallet.total',
        'wallet.pending',
        'wallet.createdAt',
        'wallet.updatedAt',
        'entity.active',
      ]);
    } else {
      qb.where('entity.id = :id', { id });
      qb.addSelect(['entity.passwordChangedAt']);
    }

    const person = await qb.getOne();
    return person;
  }

  async findById(id: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');

    qb.where('entity.id = :id', { id });

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

    if (this.repository.metadata.name === Entities.User || this.repository.metadata.name === Entities.Driver) {
      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect([
        'wallet.id',
        'wallet.total',
        'wallet.pending',
        'wallet.createdAt',
        'wallet.updatedAt',
        'entity.active',
        'entity.disactiveAt',
      ]);
    } else {
      qb.addSelect(['entity.passwordChangedAt', 'entity.password']);
    }

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();
    return person;
  }

  async findOneByPhone(phone: string, withDeleted = false): Promise<Entity> {
    const qb = this.repository.createQueryBuilder('entity');

    qb.where('entity.phone = :phone', { phone });

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

    if (this.repository.metadata.name === Entities.User || this.repository.metadata.name === Entities.Driver) {
      qb.leftJoin('entity.wallet', 'wallet');
      qb.addSelect(['wallet.id', 'wallet.total', 'wallet.pending', 'entity.active', 'entity.disactiveAt']);
    } else {
      qb.addSelect(['entity.passwordChangedAt', 'entity.password']);
    }

    if (withDeleted) qb.withDeleted();

    const person = await qb.getOne();

    return person;
  }
}
