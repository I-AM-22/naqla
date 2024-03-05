import { Injectable } from '@nestjs/common';
import { CreateOtpDto } from './dto/create-otp.dto';
import { OtpRepository } from './repositories/otp.repository';
import { OTP_TYPE } from './otp.enum';

@Injectable()
export class OtpsService {
  constructor(private otpRepository: OtpRepository) {}
  async create(dto: CreateOtpDto, otp?: { phone: string; type: OTP_TYPE }) {
    if (otp) await this.update(otp);

    return this.otpRepository.create(dto);
  }

  findAll(phone: string, type: OTP_TYPE) {
    return this.otpRepository.find(phone, type);
  }

  findOneOtp(phone: string, otp: string, phoneConfirm: boolean) {
    return this.otpRepository.findOneOtp(phone, otp, phoneConfirm);
  }

  findOne(phone: string, type: OTP_TYPE) {
    return this.otpRepository.findOne(phone, type);
  }

  async update(otp: { phone: string; type: OTP_TYPE }) {
    return this.otpRepository.update(otp);
  }
}
