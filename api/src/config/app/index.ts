import { registerAs } from '@nestjs/config';

const AppConfig = registerAs('application', () => ({
  name: process.env.APP_NAME,
  port: process.env.PORT || 3000,
  env: process.env.ENV,
}));

const CloudinaryConfig = registerAs('cloudinary', () => ({
  cloud_name: process.env.CLOUDINARY_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
}));

const JwtConfig = registerAs('jwt', () => ({
  jwt_secret: process.env.JWT_SECRET,
  jwt_expires_in: process.env.JWT_EXPIRES_IN,
}));

const SuperAdminInfo = registerAs('superadmin', () => ({
  firstName: process.env.SUPER_ADMIN_FIRST_NAME,
  lastName: process.env.SUPER_ADMIN_LAST_NAME,
  phone: process.env.SUPER_ADMIN_PHONE,
  password: process.env.SUPER_ADMIN_PASSWORD,
}));

export { AppConfig, CloudinaryConfig, JwtConfig, SuperAdminInfo };
