import { Injectable } from '@nestjs/common';
import { Otp } from '../entities/otp.entity';
import { MoreThan, Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { CreateOtpDto } from '../dto/create-otp.dto';
import { OTP_TYPE } from '../otp.enum';

@Injectable()
export class OtpRepository {
  constructor(
    @InjectRepository(Otp) private readonly otpRepo: Repository<Otp>,
  ) {}

  async find(phone: string, type: OTP_TYPE) {
    return await this.otpRepo.find({
      where: { phone, valid: true, expiresIn: MoreThan(new Date()), type },
      order: { createdAt: -1 },
    });
  }

  async findOne(phone: string, type: OTP_TYPE) {
    return await this.otpRepo.findOne({
      where: {
        phone,
        valid: true,
        expiresIn: MoreThan(new Date()),
        type,
      },
      order: { createdAt: -1 },
    });
  }

  async findOneOtp(phone: string, otp: string, phoneConfirm: boolean) {
    if (phoneConfirm) {
      return await this.otpRepo.findOne({
        where: {
          otp,
          phone,
          valid: true,
          expiresIn: MoreThan(new Date()),
          type: OTP_TYPE.CHANGE_NUMBER,
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
        },
        {
          otp,
          phone,
          valid: true,
          expiresIn: MoreThan(new Date()),
          type: OTP_TYPE.LOGIN,
        },
      ],
      order: { createdAt: -1 },
    });
  }

  async create(dto: CreateOtpDto) {
    const otp = this.otpRepo.create({ ...dto, otp: '123456' });
    await this.otpRepo.save(otp);
    return otp;
  }

  async update(otp: { phone: string; type: OTP_TYPE }) {
    await this.otpRepo.update(otp, { valid: false });
  }
}
