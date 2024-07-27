import validateConfig from '@common/helpers/validate-config';
import { registerAs } from '@nestjs/config';
import { IsString, IsOptional, IsUrl } from 'class-validator';
import { HyperPayConfig } from './hyper-pay-config.type';

class HyperPayEnvironmentVariablesValidator {
  @IsString()
  @IsOptional()
  HYPER_PAY_ACCESS_TOKEN: string;

  @IsString()
  @IsOptional()
  HYPER_PAY_MADA_ENTITY_ID: string;

  @IsString()
  @IsOptional()
  HYPER_PAY_VM_ENTITY_ID: string;

  @IsUrl()
  @IsOptional()
  HYPER_PAY_API: string;

  @IsString()
  @IsOptional()
  HYPER_PAY_CURRENCY: string;

  @IsString()
  @IsOptional()
  HYPER_PAY_PAYMENT_TYPE: string;
}

const hyperPayConfig = registerAs<HyperPayConfig>('hyperPay', () => {
  validateConfig(process.env, HyperPayEnvironmentVariablesValidator);
  return {
    accessToken: process.env.HYPER_PAY_ACCESS_TOKEN,
    madaEntityId: process.env.HYPER_PAY_MADA_ENTITY_ID,
    vmEntityId: process.env.HYPER_PAY_VM_ENTITY_ID,
    api: process.env.HYPER_PAY_API,
    currency: process.env.HYPER_PAY_CURRENCY,
    paymentType: process.env.HYPER_PAY_PAYMENT_TYPE,
  };
});

export default hyperPayConfig;
