/*
https://docs.nestjs.com/openapi/decorators#decorators
*/

import { createParamDecorator, Param, ParseUUIDPipe } from '@nestjs/common';

export const Id = createParamDecorator(() => Param('id', ParseUUIDPipe));
