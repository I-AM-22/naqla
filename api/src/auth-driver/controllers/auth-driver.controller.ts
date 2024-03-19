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
  UseGuards,
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
import { GetUser, Public, Roles } from '../../common/decorators';
import { GROUPS, ROLE } from '../../common/enums';
import {
  SignUpDriverDto,
  LoginDriverDto,
  ConfirmDriverDto,
  UpdateDriverPhoneDto,
} from '../dtos';
import { AUTH_DRIVER_TYPES, AuthDriverResponse } from '../interfaces';
import {
  bad_req,
  confirmMessage,
  data_not_found,
  denied_error,
} from '../../common/constants';
import { Driver } from '../../models/drivers';
import { item_already_exist } from '../../common/constants/validation-errors.constant';
import { IAuthDriverService } from '../interfaces/services/auth.service.interface';
import { SendConfirm } from '../../common/types';
import { RolesGuard } from '../../common/guards';

/**
 * @ngdoc controller
 * @name AuthDriverController
 *
 * @description
 * My controller description.
 */
@ApiTags('auth-driver')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@ApiUnprocessableEntityResponse({ description: item_already_exist('mobile') })
@UseGuards(RolesGuard)
@Controller({ path: 'auth/driver', version: '1' })
export class AuthDriverController {
  constructor(
    @Inject(AUTH_DRIVER_TYPES.service)
    private authDriverService: IAuthDriverService,
  ) {}

  @Public()
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @ApiCreatedResponse({ description: confirmMessage, type: SendConfirm })
  @Post('signup')
  signup(@Body() dto: SignUpDriverDto, @Ip() ip: string) {
    return this.authDriverService.signup(dto, ip);
  }

  @Public()
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: confirmMessage,
    type: SendConfirm,
  })
  @Post('login')
  login(@Body() dto: LoginDriverDto, @Ip() ip: string) {
    return this.authDriverService.login(dto, ip);
  }

  @Public()
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Confirm' })
  @ApiOkResponse({
    description: 'Account is confirmed',
    type: AuthDriverResponse,
  })
  @ApiQuery({
    name: 'phoneConfirm',
    type: 'boolean',
    description: 'assign true to the field to confirm new number',
  })
  @Post('confirm')
  async confirm(
    @Query('phoneConfirm') phoneConfirm: boolean,
    @Body() confirmEmailDto: ConfirmDriverDto,
    @Ip() ip: string,
  ): Promise<AuthDriverResponse> {
    return this.authDriverService.confirm(confirmEmailDto, ip, phoneConfirm);
  }

  @ApiOperation({ summary: 'update phone number' })
  @ApiOkResponse({
    description: confirmMessage,
    type: SendConfirm,
  })
  @Roles(ROLE.DRIVER)
  @SerializeOptions({ groups: [GROUPS.DRIVER] })
  @Patch('updateMyNumber')
  async updateMyNumber(
    @Body() dto: UpdateDriverPhoneDto,
    @Ip() ip: string,
    @GetUser() driver: Driver,
  ): Promise<SendConfirm> {
    return this.authDriverService.updatePhone(dto, ip, driver);
  }
}
