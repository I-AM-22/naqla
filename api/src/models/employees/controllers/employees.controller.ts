import { ApiNoContentResponse, ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { Employee } from '../entities/employee.entity';
import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Patch,
  Post,
  Req,
  SerializeOptions,
} from '@nestjs/common';
import { Public, CheckAbilities, Id, Auth, ApiMainErrorsResponse } from '@common/decorators';
import { GROUPS, Entities, Action } from '@common/enums';
import { CreateEmployeeDto, LoginEmployeeDto, UpdateEmployeeDto } from '../dtos';
import { ICrud } from '@common/interfaces';
import { AuthEmployeeResponse } from '../interfaces';
import { Request } from 'express';
import { EmployeesService } from '../services/employees.service';

@ApiTags('Employees')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'employees', version: '1' })
export class EmployeesController implements ICrud<Employee> {
  constructor(private readonly employeesService: EmployeesService) {}
  @Public()
  @ApiOperation({ summary: 'Login' })
  @ApiOkResponse({
    description: 'Employee logged in successfully',
    type: AuthEmployeeResponse,
  })
  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @HttpCode(HttpStatus.OK)
  @Post('login')
  login(@Body() dto: LoginEmployeeDto) {
    return this.employeesService.login(dto);
  }

  @ApiOkResponse({ type: Employee, isArray: true })
  @SerializeOptions({ groups: [GROUPS.ALL_EMPLOYEES] })
  @CheckAbilities({ action: Action.Read, subject: Entities.Employee })
  @Get()
  find(@Req() req: Request) {
    return this.employeesService.find();
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
  findOne(@Id() id: string) {
    return this.employeesService.findOne(id);
  }

  @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  @ApiOkResponse({ type: Employee })
  @CheckAbilities({ action: Action.Update, subject: Entities.Employee })
  @Patch(':id')
  update(@Id() id: string, @Body() dto: UpdateEmployeeDto) {
    return this.employeesService.update(id, dto);
  }

  @ApiNoContentResponse()
  @CheckAbilities({ action: Action.Delete, subject: Entities.Employee })
  @HttpCode(HttpStatus.NO_CONTENT)
  @Delete(':id')
  delete(@Id() id: string) {
    return this.employeesService.delete(id);
  }

  // @ApiOperation({ summary: 'recover deleted Employee' })
  // @CheckAbilities({ action: Action.Update, subject: Entities.Employee })
  // @SerializeOptions({ groups: [GROUPS.EMPLOYEE] })
  // @HttpCode(HttpStatus.OK)
  // @Post(':id/recover')
  // recover(@Id() id: string) {
  //   return this.employeesService.recover(id);
  // }
}
