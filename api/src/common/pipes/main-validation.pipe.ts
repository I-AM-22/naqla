import { errorsFormat } from '@common/helpers';
import { Injectable, ValidationPipe } from '@nestjs/common';

@Injectable()
export class MainValidationPipe extends ValidationPipe {
  constructor() {
    super({
      transform: true,
      whitelist: true,
      forbidNonWhitelisted: true,
      validationError: { target: false },
      exceptionFactory: (errors) => {
        errorsFormat(errors);
      },
    });
  }
}
