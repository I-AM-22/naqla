import { ForbiddenError } from '@casl/ability';
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  UnauthorizedException,
  ForbiddenException,
  InternalServerErrorException,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { HttpAdapterHost } from '@nestjs/core';
import { Response } from 'express';
import { AppConfig } from '@config/app';
import { ConfigType } from '@nestjs/config';
import { denied_error } from '../constants';
import { ErrorType } from '@common/enums/error-type.enum';

const handelPassportError = () => new UnauthorizedException({ message: 'الرجاء تسجيل الدخول' });

const handelDuplicatedRecords = (detail: string) => {
  const match = detail.match(/Key \("(.+)", "(.+)"\)/);
  return new ConflictException(`Record already exist on table(s): ${match[1]}, ${match[2]}`);
};

@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  constructor(
    private readonly httpAdapterHost: HttpAdapterHost,
    private readonly appConfig: ConfigType<typeof AppConfig>,
  ) {}

  catch(exception: any, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();

    console.log(exception);
    let error: any =
      exception instanceof ForbiddenError
        ? new ForbiddenException(denied_error)
        : exception.code === '23505'
          ? handelDuplicatedRecords(exception.detail)
          : exception.code === '23503'
            ? new NotFoundException(exception.detail + ' not found')
            : exception instanceof HttpException
              ? exception
              : new InternalServerErrorException('something went very wrong');

    if (error.message === 'Unauthorized') error = handelPassportError();

    // if (this.appConfig.env === 'production') {
    const rep = {
      type: error.response.errors ? ErrorType.Form : ErrorType.Default,
      message: error.response.errors ? undefined : error.message,
      errors: error.response.errors,
    };
    this.reply(response, rep, error.getStatus());
    // } else {
    //   const rep = {
    //     error: exception,
    //     stack: exception.stack,
    //     message: error.message,
    //   };
    //   this.reply(response, rep, error.getStatus());
    // }
  }

  reply(response: Response, rep: any, status: number) {
    const { httpAdapter } = this.httpAdapterHost;
    httpAdapter.reply(response, rep, status);
  }
}
