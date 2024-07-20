import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne } from 'typeorm';
import { BasePersonWithActive, BasePhoto } from './../../../common/base';
import { Exclude, Expose, Transform } from 'class-transformer';
import { GROUPS } from '@common/enums';
import { Role } from '@models/roles/entities/role.entity';
import { UserPhoto } from './user-photo.entity';
import { Order } from '@models/orders/entities/order.entity';
import { ApiProperty } from '@nestjs/swagger';
import { UserWallet } from './user-wallet.entity';

@Entity({ name: 'users' })
export class User extends BasePersonWithActive {
  @Expose({ groups: [GROUPS.USER] })
  @Transform(({ value }) => value.name)
  @ManyToOne(() => Role, (role) => role.users)
  @JoinColumn({ name: 'roleId' })
  role: Role;

  @Exclude()
  @Column()
  roleId: string;

  @ApiProperty({ type: UserWallet })
  @OneToOne(() => UserWallet, (wallet) => wallet.user, {
    onDelete: 'CASCADE',
    cascade: true,
  })
  wallet: UserWallet;

  @Exclude()
  @OneToMany(() => UserPhoto, (userPhoto) => userPhoto.user, {
    cascade: true,
    eager: true,
  })
  photos: UserPhoto[];

  @OneToMany(() => Order, (order) => order.user, { cascade: true })
  orders: Order[];

  @Expose({})
  @ApiProperty({ type: BasePhoto })
  photo() {
    if (this.photos) return this.photos[this.photos.length - 1];
    return undefined;
  }
}
