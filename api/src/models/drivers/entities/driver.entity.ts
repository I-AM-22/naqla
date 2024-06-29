import { Column, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne } from 'typeorm';
import { BasePersonWithActive, BasePhoto } from '@common/base';
import { Exclude, Expose, Transform } from 'class-transformer';
import { Role } from '@models/roles/entities/role.entity';
import { DriverPhoto } from './driver-photo.entity';
import { ApiProperty } from '@nestjs/swagger';
import { DriverWallet } from './driver-wallet.entity';
import { Car } from '../../cars/entities/car.entity';

@Entity({ name: 'drivers' })
export class Driver extends BasePersonWithActive {
  // @Expose({ groups: [GROUPS.DRIVER] })
  @Transform(({ value }) => value.name)
  @ManyToOne(() => Role, (role) => role.drivers)
  @JoinColumn({ name: 'roleId' })
  role: Role;

  @Exclude()
  @Column()
  roleId: string;

  @ApiProperty({ type: DriverWallet })
  // @Expose({ groups: [GROUPS.DRIVER] })
  @OneToOne(() => DriverWallet, (wallet) => wallet.driver, {
    onDelete: 'CASCADE',
    cascade: true,
  })
  wallet: DriverWallet;

  @OneToMany(() => Car, (car) => car.driver, { cascade: true })
  cars: Car[];

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
