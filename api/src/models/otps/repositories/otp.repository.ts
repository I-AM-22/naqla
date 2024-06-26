import { Injectable } from '@nestjs/common';
import { Otp } from '../entities/otp.entity';
import { MoreThan, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateOtpDto } from '../dto/create-otp.dto';
import { OTP_PERSON, OTP_TYPE } from '@common/enums/otp.enum';
import { IOtp } from '../interfaces/otp.interface';

@Injectable()
export class OtpRepository {
  constructor(@InjectRepository(Otp) private readonly otpRepo: Repository<Otp>) {}

  async find(phone: string, ip: string, type: OTP_TYPE, perType: OTP_PERSON) {
    return await this.otpRepo.find({
      where: {
        phone,
        valid: true,
        expiresIn: MoreThan(new Date()),
        type,
        perType,
        ip,
      },
      order: { createdAt: -1 },
    });
  }

  async findOne(phone: string, ip: string, type: OTP_TYPE, perType: OTP_PERSON) {
    return await this.otpRepo.findOne({
      where: {
        phone,
        valid: true,
        expiresIn: MoreThan(new Date()),
        type,
        perType,
        ip,
      },
      order: { createdAt: -1 },
    });
  }

  async findOneOtp(phone: string, otp: string, ip: string, perType: OTP_PERSON, phoneConfirm: boolean) {
    if (phoneConfirm) {
      return await this.otpRepo.findOne({
        where: {
          otp,
          phone,
          valid: true,
          expiresIn: MoreThan(new Date()),
          type: OTP_TYPE.CHANGE_NUMBER,
          perType,
          ip,
        },
        order: { createdAt: -1 },
      });
    }
    return await this.otpRepo.findOne({
      where: [
        {
          otp,
          phone,
          valid: true,
          expiresIn: MoreThan(new Date()),
          type: OTP_TYPE.SIGNUP,
          perType,
          ip,
        },
        {
          otp,
          phone,
          valid: true,
          expiresIn: MoreThan(new Date()),
          type: OTP_TYPE.LOGIN,
          perType,
          ip,
        },
      ],
      order: { createdAt: -1 },
    });
  }

  async create(dto: CreateOtpDto, perType: OTP_PERSON) {
    const otp = this.otpRepo.create({
      ...dto,
      otp: '123456',
      expiresIn: new Date(Date.now() + 24 * 60 * 60 * 1000),
      perType,
    });
    await this.otpRepo.save(otp);
    return otp;
  }

  async update(otp: IOtp) {
    await this.otpRepo.update(
      {
        userId: otp.userId,
        phone: otp.phone,
        ip: otp.ip,
        type: otp.type,
        perType: otp.perType,
      },
      { valid: false },
    );
  }
}
