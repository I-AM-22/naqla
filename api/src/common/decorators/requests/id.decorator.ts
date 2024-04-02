/*
https://docs.nestjs.com/openapi/decorators#decorators
*/

import { Param, ParseUUIDPipe } from '@nestjs/common';

export const Id = () => Param('id', ParseUUIDPipe);
