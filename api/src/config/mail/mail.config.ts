import { registerAs } from '@nestjs/config';
import { IsString, IsOptional, IsNumber, IsEmail } from 'class-validator';
import validateConfig from '@common/helpers/validate-config';
import { MailConfig } from './mail-config.type';

class EnvironmentVariablesValidator {
  @IsString()
  @IsOptional()
  MAIL_USER: string;

  @IsString()
  @IsOptional()
  MAIL_PASS: string;

  @IsNumber()
  @IsOptional()
  MAIL_PORT: number;

  @IsString()
  @IsOptional()
  MAIL_HOST: string;

  @IsString()
  @IsOptional()
  MAIL_SECURE: string;

  @IsString()
  @IsOptional()
  MAIL_USER_R: string;

  @IsString()
  @IsOptional()
  MAIL_PASS_R: string;

  @IsString()
  @IsOptional()
  @IsEmail()
  MAIL_FROM: string;

  @IsString()
  @IsOptional()
  MAIL_FROM_NAME: string;

  @IsString()
  @IsOptional()
  MAIL_QUEUE_NAME: string;

  @IsString()
  @IsOptional()
  MAIL_QUEUE_HOST: string;

  @IsNumber()
  @IsOptional()
  MAIL_QUEUE_PORT: number;
}

const mailConfig = registerAs<MailConfig>('mail', () => {
  validateConfig(process.env, EnvironmentVariablesValidator);
  return {
    user: process.env.MAIL_USER,
    pass: process.env.MAIL_PASS,
    port: Number(process.env.MAIL_PORT),
    host: process.env.MAIL_HOST,
    secure: process.env.MAIL_SECURE,
    user_r: process.env.MAIL_USER_R,
    pass_r: process.env.MAIL_PASS_R,
    from: process.env.MAIL_FROM,
    from_name: process.env.MAIL_FROM_NAME,
    queue_name: process.env.MAIL_QUEUE_NAME,
    queue_host: process.env.MAIL_QUEUE_HOST,
    queue_port: Number(process.env.MAIL_QUEUE_PORT),
  };
});

export default mailConfig;
