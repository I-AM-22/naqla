import { Column, Entity, JoinColumn, ManyToOne } from 'typeorm';
import { User } from './user.entity';
import { BasePhoto } from '@common/base';
import { Exclude } from 'class-transformer';

@Entity({ name: 'users_photos' })
export class UserPhoto extends BasePhoto {
  @ManyToOne(() => User, (user) => user.photos)
  @JoinColumn({ name: 'userId' })
  user: User;

  @Exclude()
  @Column()
  userId: string;
}
