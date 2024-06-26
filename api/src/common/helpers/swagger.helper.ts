import { INestApplication } from '@nestjs/common';
import { DocumentBuilder, OpenAPIObject, SwaggerCustomOptions, SwaggerModule } from '@nestjs/swagger';
import { SwaggerConfig } from '../types';

export const SWAGGER_CONFIG: SwaggerConfig = {
  title: 'naqleh',
  description: 'naqleh API',
  version: '1.0',
};

export function createDocument(app: INestApplication): {
  document: OpenAPIObject;
  setupOptions: SwaggerCustomOptions;
} {
  const builder = new DocumentBuilder()
    .setTitle(SWAGGER_CONFIG.title)
    .setDescription(SWAGGER_CONFIG.description)
    .setVersion(SWAGGER_CONFIG.version)
    .addBearerAuth({ type: 'http', scheme: 'bearer', bearerFormat: 'jwt' }, 'token');

  const options = builder.build();
  const document = SwaggerModule.createDocument(app, options);
  Object.values((document as OpenAPIObject).paths).forEach((path: any) => {
    Object.values(path).forEach((method: any) => {
      if (Array.isArray(method.security) && method.security.includes('isPublic')) {
        method.security = [];
      }
    });
  });
  const setupOptions: SwaggerCustomOptions = {
    swaggerOptions: {
      persistAuthorization: true,
    },
    jsonDocumentUrl: '/api.json',
    customSiteTitle: 'naqleh',
  };
  return { document, setupOptions };
}
