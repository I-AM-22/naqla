import { ForbiddenError } from '@casl/ability';
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  UnauthorizedException,
  HttpStatus,
  ForbiddenException,
  InternalServerErrorException,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { AbstractHttpAdapter, HttpAdapterHost } from '@nestjs/core';
import { Response } from 'express';
import { AppConfig } from '../../config/app';
import { ConfigType } from '@nestjs/config';
import { denied_error } from '../constants';

const handelPassportError = () =>
  new UnauthorizedException({ message: 'الرجاء تسجيل الدخول' });

@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  constructor(
    private readonly httpAdapterHost: HttpAdapterHost,
    private readonly appConfig: ConfigType<typeof AppConfig>,
  ) {}

  catch(exception: any, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    let error: any =
      exception instanceof ForbiddenError
        ? new ForbiddenException(denied_error)
        : exception.code === '23505'
        ? new BadRequestException(exception.detail)
        : exception.code === '23503'
        ? new NotFoundException(exception.detail + ' not found')
        : exception instanceof HttpException
        ? exception
        : new InternalServerErrorException('something went very wrong');

    if (error.message === 'Unauthorized') error = handelPassportError();

    if (this.appConfig.env === 'production') {
      if (error.getStatus() === 500) console.log(exception);
      const rep = {
        type: error.errors ? 'form' : 'default',
        message: error.message,
        errors: error.errors,
      };
      this.reply(response, rep, error.getStatus());
    } else {
      const rep = {
        error: exception,
        stack: exception.stack,
        message: error.message,
      };
      this.reply(response, rep, error.getStatus());
    }
  }

  reply(response: Response, rep: any, status: number) {
    const { httpAdapter } = this.httpAdapterHost;
    httpAdapter.reply(response, rep, status);
  }
}
