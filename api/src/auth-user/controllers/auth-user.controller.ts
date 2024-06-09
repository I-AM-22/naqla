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
  Ip,
} from '@nestjs/common';
import {
  ApiTags,
  ApiCreatedResponse,
  ApiOperation,
  ApiOkResponse,
  ApiBearerAuth,
  ApiQuery,
  ApiBadRequestResponse,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiUnprocessableEntityResponse,
} from '@nestjs/swagger';
import { GetUser, Public, Roles } from '@common/decorators';
import { GROUPS, ROLE } from '@common/enums';
import {
  SignUpUserDto,
  LoginUserDto,
  ConfirmUserDto,
  UpdateUserPhoneDto,
} from '../dtos';
import { AuthUserResponse } from '../interfaces';
import { IAuthUserService } from '../interfaces/services/auth.service.interface';
import { AUTH_TYPES } from '../interfaces';
import {
  bad_req,
  confirmMessage,
  data_not_found,
  denied_error,
} from '@common/constants';
import { User } from '@models/users/entities/user.entity';
import { item_already_exist } from '@common/constants/validation-errors.constant';
import { SendConfirm } from '@common/types';

/**
 * @ngdoc controller
 * @name AuthUserController
 *
 * @description
 * My controller description.
 */
@ApiTags('Auth-User')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@ApiUnprocessableEntityResponse({ description: item_already_exist('mobile') })
@Controller({ path: 'auth/user', version: '1' })
export class AuthUserController {
  constructor(
    @Inject(AUTH_TYPES.service) private authUserService: IAuthUserService,
  ) {}

  @Public()
  @SerializeOptions({ groups: [GROUPS.USER] })
  @ApiCreatedResponse({ description: confirmMessage, type: SendConfirm })
  @Post('signup')
  signup(@Body() dto: SignUpUserDto, @Ip() ip: string) {
    return this.authUserService.signup(dto, ip);
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
  login(@Body() dto: LoginUserDto, @Ip() ip: string) {
    return this.authUserService.login(dto, ip);
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
    @Body() confirmEmailDto: ConfirmUserDto,
    @Ip() ip: string,
  ): Promise<AuthUserResponse> {
    return this.authUserService.confirm(confirmEmailDto, ip, phoneConfirm);
  }

  @ApiOperation({ summary: 'update phone number' })
  @ApiOkResponse({
    description: confirmMessage,
    type: SendConfirm,
  })
  @Roles(ROLE.USER)
  @SerializeOptions({ groups: [GROUPS.USER] })
  @Patch('updateMyNumber')
  async updateMyNumber(
    @Body() dto: UpdateUserPhoneDto,
    @Ip() ip: string,
    @GetUser() user: User,
  ): Promise<SendConfirm> {
    return this.authUserService.updatePhone(dto, ip, user);
  }
}
