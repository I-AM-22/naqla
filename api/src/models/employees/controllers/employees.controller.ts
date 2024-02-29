import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { Employee } from '../entities/employee.entity';
import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Inject,
  Param,
  ParseUUIDPipe,
  Patch,
  Post,
  Req,
  SerializeOptions,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { Public, CheckAbilities } from '../../../common/decorators';
import { GROUPS, Entities, Action } from '../../../common/enums';
import { CaslAbilitiesGuard } from '../../../common/guards';
import { CreateEmployeeDto, UpdateEmployeeDto } from '../dtos';
import { LoginDto } from '../../../auth-user/dtos/login.dto';
import { ICrud } from '../../../common/interfaces';
import { AuthEmployeeResponse } from '../interfaces';
import {
  bad_req,
  data_not_found,
  denied_error,
} from '../../../common/constants';
import { WithDeletedInterceptor } from '../../../common/interceptors';
import { Request } from 'express';
import { EMPLOYEE_TYPES } from '../interfaces/type';
import { IEmployeeService } from '../interfaces/employee-services.interface';

@ApiTags('Employees')
@ApiBearerAuth('token')
@ApiBadRequestResponse({ description: bad_req })
@ApiForbiddenResponse({ description: denied_error })
@ApiNotFoundResponse({ description: data_not_found })
@UseGuards(CaslAbilitiesGuard)
@Controller({ path: 'employees', version: '1' })
export class EmployeesController implements ICrud<Employee> {
  constructor(
    @Inject(EMPLOYEE_TYPES.service)
    private readonly employeesService: IEmployeeService,
  ) {}
  @Public()
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: 'Employee logged in successfully',
    type: AuthEmployeeResponse,
  })
  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @HttpCode(HttpStatus.OK)
  @Post('login')
  login(@Body() dto: LoginDto) {
    return this.employeesService.login(dto);
  }

  @UseInterceptors(WithDeletedInterceptor)
  @ApiOkResponse({ type: Employee })
  @SerializeOptions({ groups: [GROUPS.ALL_EMPLOYEES] })
  @CheckAbilities({ action: Action.Read, subject: Entities.Employee })
  @Get()
  find(@Req() req: Request) {
    const withDeleted = Boolean(req.query.withDeleted);
    return this.employeesService.find(withDeleted);
  }

  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @ApiOkResponse({ type: Employee })
  @CheckAbilities({ action: Action.Create, subject: Entities.Employee })
  @Post()
  create(@Body() createEmployeeDto: CreateEmployeeDto) {
    return this.employeesService.create(createEmployeeDto);
  }

  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @ApiOkResponse({ type: Employee })
  @CheckAbilities({ action: Action.Read, subject: Entities.Employee })
  @Get(':id')
  findOne(@Param('id', ParseUUIDPipe) id: string) {
    return this.employeesService.findOne(id);
  }

  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @ApiOkResponse({ type: Employee })
  @CheckAbilities({ action: Action.Update, subject: Entities.Employee })
  @Patch(':id')
  update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body() dto: UpdateEmployeeDto,
  ) {
    return this.employeesService.update(id, dto);
  }

  @ApiNoContentResponse()
  @CheckAbilities({ action: Action.Delete, subject: Entities.Employee })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  remove(@Param('id', ParseUUIDPipe) id: string) {
    return this.employeesService.remove(id);
  }

  // @ApiOperation({ summary: 'recover deleted Employee' })
  // @CheckAbilities({ action: Action.Update, subject: Entities.Employee })
  // @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // recover(@Param('id', ParseUUIDPipe) id: string) {
  //   return this.employeesService.recover(id);
  // }
}
