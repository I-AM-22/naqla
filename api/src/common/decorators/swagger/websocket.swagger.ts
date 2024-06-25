import { applyDecorators } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiBody } from '@nestjs/swagger';

export function ApiWebSocketEvent(
  event: string,
  description: string,
  resEvent: string,
  response: any,
  dto?: any,
) {
  return applyDecorators(
    ApiOperation({ summary: `WebSocket Event: ${event}`, description }),
    ApiBody({ type: dto || Object }),
    ApiResponse({
      status: 200,
      type: response,
      description: `Event: "${resEvent}" will be emitted`,
    }),
  );
}
