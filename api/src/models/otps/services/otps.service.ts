import { Injectable } from '@nestjs/common';
import { CreateOtpDto } from '../dto/create-otp.dto';
import { OtpRepository } from '../repositories/otp.repository';
import { OTP_PERSON, OTP_TYPE } from '@common/enums/otp.enum';
import { IOtp } from '../interfaces/otp.interface';

@Injectable()
export class OtpsService {
  constructor(private otpRepository: OtpRepository) {}
  async createForUser(dto: CreateOtpDto, otp?: IOtp) {
    if (otp) await this.updateForUser(otp);
    return this.otpRepository.create(dto, OTP_PERSON.USER);
  }

  findAllForUser(phone: string, ip: string, type: OTP_TYPE) {
    return this.otpRepository.find(phone, ip, type, OTP_PERSON.USER);
  }

  findOneOtpForUser(phone: string, otp: string, ip: string, phoneConfirm: boolean) {
    return this.otpRepository.findOneOtp(phone, otp, ip, OTP_PERSON.USER, phoneConfirm);
  }

  findOneForUser(phone: string, ip: string, type: OTP_TYPE) {
    return this.otpRepository.findOne(phone, ip, type, OTP_PERSON.USER);
  }

  async updateForUser(otp: IOtp) {
    return this.otpRepository.update({ ...otp, perType: OTP_PERSON.USER });
  }

  async createForDriver(dto: CreateOtpDto, otp?: IOtp) {
    if (otp) await this.updateForDriver(otp);
    return this.otpRepository.create(dto, OTP_PERSON.DRIVER);
  }

  findAllForDriver(phone: string, ip: string, type: OTP_TYPE) {
    return this.otpRepository.find(phone, ip, type, OTP_PERSON.DRIVER);
  }

  findOneOtpForDriver(phone: string, otp: string, ip: string, phoneConfirm: boolean) {
    return this.otpRepository.findOneOtp(phone, otp, ip, OTP_PERSON.DRIVER, phoneConfirm);
  }

  findOneForDriver(phone: string, ip: string, type: OTP_TYPE) {
    return this.otpRepository.findOne(phone, ip, type, OTP_PERSON.DRIVER);
  }

  async updateForDriver(otp: IOtp) {
    return this.otpRepository.update({ ...otp, perType: OTP_PERSON.DRIVER });
  }
}
