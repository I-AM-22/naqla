import {
  Controller,
  SerializeOptions,
  Post,
  Body,
  HttpCode,
  HttpStatus,
  Inject,
  Patch,
  Query,
} from '@nestjs/common';
import {
  ApiTags,
  ApiCreatedResponse,
  ApiOperation,
  ApiOkResponse,
  ApiBearerAuth,
  ApiQuery,
} from '@nestjs/swagger';
import { GetUser, Public } from '../../common/decorators';
import { GROUPS } from '../../common/enums';
import { SignUpDto, LoginDto, ConfirmDto, UpdatePhoneDto } from '../dtos';
import { AuthUserResponse } from '../interfaces';
import { IAuthService } from '../interfaces/services/auth.service.interface';
import { AUTH_TYPES, SendConfirm } from '../interfaces';
import { confirmMessage } from '../../common/constants';
import { User } from '../../models/users';

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
  @ApiCreatedResponse({ description: confirmMessage, type: SendConfirm })
  @Post('signup')
  signup(@Body() dto: SignUpDto) {
    return this.authService.signup(dto);
  }

  @Public()
  @SerializeOptions({ groups: [GROUPS.USER] })
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: confirmMessage,
    type: SendConfirm,
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
  @ApiQuery({
    name: 'phoneConfirm',
    type: 'boolean',
    description: 'assign true to the field to confirm new number',
  })
  @Post('confirm')
  async confirm(
    @Query('phoneConfirm') phoneConfirm: boolean,
    @Body() confirmEmailDto: ConfirmDto,
  ): Promise<AuthUserResponse> {
    return this.authService.confirm(confirmEmailDto, phoneConfirm);
  }

  @SerializeOptions({ groups: [GROUPS.USER] })
  @ApiOperation({ summary: 'update phone number' })
  @ApiOkResponse({
    description: confirmMessage,
    type: SendConfirm,
  })
  @Patch('updateMyNumber')
  async updateMyNumber(
    @Body() dto: UpdatePhoneDto,
    @GetUser() user: User,
  ): Promise<SendConfirm> {
    return this.authService.updatePhone(dto, user);
  }
}
