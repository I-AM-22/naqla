import {
  Controller,
  SerializeOptions,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Patch,
  UseGuards,
  Req,
  Inject,
} from '@nestjs/common';
import {
  ApiTags,
  ApiCreatedResponse,
  ApiOperation,
  ApiOkResponse,
  ApiBearerAuth,
} from '@nestjs/swagger';
import { Public, GetUser, Roles } from '../../common/decorators';
import { GROUPS, ROLE } from '../../common/enums';
import {
  SignUpDto,
  PasswordChangeDto,
  LoginDto,
  ForgotPasswordDto,
  ResetPasswordDto,
  AuthConfirmEmailDto,
} from '../dtos';
import { RolesGuard } from '../../common/guards';
import { AuthUserResponse } from '../interfaces';
import { Request } from 'express';
import { IAuthService } from '../interfaces/services/auth.service.interface';
import { AUTH_TYPES } from '../interfaces/type';

/**
 * @ngdoc controller
 * @name AuthController
 *
 * @description
 * My controller description.
 */
@ApiTags('auth')
@ApiBearerAuth('token')
@Controller({ path: 'auth', version: '1' })
export class AuthController {
  constructor(@Inject(AUTH_TYPES.service) private authService: IAuthService) {}

  @Public()
  @SerializeOptions({ groups: [GROUPS.USER] })
  @ApiCreatedResponse({ type: AuthUserResponse })
  @Post('signup')
  signup(@Body() dto: SignUpDto) {
    return this.authService.signup(dto);
  }

  @Public()
  @SerializeOptions({ groups: [GROUPS.USER] })
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: 'User logged in successfully',
    type: AuthUserResponse,
  })
  @Post('login')
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }

  @Public()
  @SerializeOptions({ groups: [GROUPS.USER] })
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Confirm' })
  @ApiOkResponse({
    description: 'Account is confirmed',
    type: AuthUserResponse,
  })
  @Post('confirm')
  async confirm(
    @Body() confirmEmailDto: AuthConfirmEmailDto,
  ): Promise<AuthUserResponse> {
    return this.authService.confirm(confirmEmailDto.otp);
  }

  @Public()
  @ApiOperation({ summary: 'Forgot Password' })
  @ApiOkResponse({
    description: 'send reset password email if you forgot password',
    schema: {
      example: { message: 'تم ارسال رمز اعادة التعيين لبريدك الالكتروني' },
    },
  })
  @HttpCode(HttpStatus.OK)
  @Post('forgotPassword')
  async forgotPassword(@Body() dto: ForgotPasswordDto) {
    return this.authService.forgotPassword(dto);
  }

  @Public()
  @ApiOperation({ summary: 'Reset Password' })
  @ApiOkResponse({
    description: 'Your account password has been reset',
    type: AuthUserResponse,
  })
  @SerializeOptions({ groups: [GROUPS.USER] })
  @HttpCode(HttpStatus.OK)
  @Post('resetPassword')
  async resetPassword(
    @Body() dto: ResetPasswordDto,
    @Req() request: Request,
  ): Promise<AuthUserResponse> {
    const dynamicOrigin = `${request.protocol}://${request.get('host')}`;

    return this.authService.resetPassword(dto, dynamicOrigin);
  }

  @SerializeOptions({ groups: [GROUPS.USER] })
  @UseGuards(RolesGuard)
  @Roles(ROLE.USER)
  @Patch('updateMyPassword')
  updateMyPassword(
    @Body() dto: PasswordChangeDto,
    @GetUser('phone') phone: string,
  ) {
    return this.authService.updateMyPassword(dto, phone);
  }
}
