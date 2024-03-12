import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  OneToOne,
} from 'typeorm';
import { BasePersonWithActive, BasePhoto } from '../../../common/base';
import { Exclude, Expose, Transform } from 'class-transformer';
import { GROUPS } from '../../../common/enums';
import { Role } from '../../roles';
import { DriverPhoto } from './driver-photo.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Wallet } from './wallet.entity';

@Entity({ name: 'drivers' })
export class Driver extends BasePersonWithActive {
  @Expose({ groups: [GROUPS.DRIVER] })
  @Transform(({ value }) => value.name)
  @ManyToOne(() => Role, (role) => role.drivers)
  @JoinColumn({ name: 'roleId' })
  role: Role;

  @Exclude()
  @Column()
  roleId: string;

  @ApiProperty({ type: Wallet })
  @Expose({ groups: [GROUPS.DRIVER] })
  @OneToOne(() => Wallet, (wallet) => wallet.driver, {
    onDelete: 'CASCADE',
    cascade: true,
  })
  wallet: Wallet;

  @Exclude()
  @OneToMany(() => DriverPhoto, (driverPhoto) => driverPhoto.driver, {
    cascade: true,
    eager: true,
  })
  photos: DriverPhoto[];

  @Expose({})
  @ApiProperty({ type: BasePhoto })
  photo() {
    if (this.photos) return this.photos[this.photos.length - 1];
    return undefined;
  }
}
