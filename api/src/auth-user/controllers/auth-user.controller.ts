import { Controller, SerializeOptions, Post, Body, HttpCode, HttpStatus, Patch, Query, Ip } from '@nestjs/common';
import {
  ApiTags,
  ApiCreatedResponse,
  ApiOperation,
  ApiOkResponse,
  ApiQuery,
  ApiUnprocessableEntityResponse,
} from '@nestjs/swagger';
import { ApiMainErrorsResponse, Auth, GetUser, Public, Roles } from '@common/decorators';
import { GROUPS, ROLE } from '@common/enums';
import { SignUpUserDto, LoginUserDto, ConfirmUserDto, UpdateUserPhoneDto } from '../dtos';
import { AuthUserResponse } from '../interfaces';
import { confirmMessage } from '@common/constants';
import { User } from '@models/users/entities/user.entity';
import { item_already_exist } from '@common/constants/validation-errors.constant';
import { SendConfirm } from '@common/types';
import { AuthUserService } from '../services/auth-user.service';

/**
 * @ngdoc controller
 * @name AuthUserController
 *
 * @description
 * My controller description.
 */
@ApiTags('Auth-User')
@Auth()
@ApiMainErrorsResponse()
@ApiUnprocessableEntityResponse({ description: item_already_exist('mobile') })
@Controller({ path: 'auth/user', version: '1' })
export class AuthUserController {
  constructor(private authUserService: AuthUserService) {}

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
  async updateMyNumber(@Body() dto: UpdateUserPhoneDto, @Ip() ip: string, @GetUser() user: User): Promise<SendConfirm> {
    return this.authUserService.updatePhone(dto, ip, user);
  }
}
