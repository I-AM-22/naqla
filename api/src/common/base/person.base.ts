import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { Entity, Column, BeforeInsert, BeforeUpdate } from 'typeorm';
import { GlobalEntity } from './global-entity.base';
import * as argon from 'argon2';

@Entity()
export class BasePerson extends GlobalEntity {
  @ApiProperty({ example: 'Bahaa Alden' })
  @Column()
  firstName: string;

  @ApiProperty({ example: 'Abdo' })
  @Column()
  lastName: string;

  @ApiProperty({ uniqueItems: true })
  @Column({ unique: true })
  phone: string;

  // Add any other common fields for both User and Admin here
}

@Entity()
export class BasePersonWithActive extends BasePerson {
  @Exclude()
  @Column('boolean', { default: false })
  active: boolean;

  @Column({ nullable: true })
  disactiveAt: Date | null;
}

@Entity()
export class BasePersonWithPass extends BasePerson {
  @Exclude()
  @Column({ select: false })
  password: string;

  @Exclude()
  @Column({ nullable: true, select: false, type: 'timestamptz' })
  passwordChangedAt: Date;

  @Exclude()
  @Column({ nullable: true, unique: true, select: false })
  passwordResetToken: string;

  @Exclude()
  @Column({ nullable: true, select: false, type: 'timestamptz' })
  passwordResetExpires: Date;

  @BeforeInsert()
  @BeforeUpdate()
  async hash() {
    if (this.password) {
      this.password = await this.generateHash(this.password);
    }
  }

  @BeforeUpdate()
  async passChanged() {
    if (this.password) {
      this.passwordChangedAt = new Date(Date.now() - 1000);
    }
  }

  isPasswordChanged(JWTTimestamp: number) {
    if (this.passwordChangedAt) {
      const changeTimestamp: number = this.passwordChangedAt.getTime() / 1000;
      return changeTimestamp > JWTTimestamp;
    }
    return false;
  }

  async generateHash(password: string) {
    return await argon.hash(password);
  }

  async verifyHash(hash: string, password: string) {
    return await argon.verify(hash, password);
  }
}
