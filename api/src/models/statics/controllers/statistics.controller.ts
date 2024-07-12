import { ApiMainErrorsResponse, Auth, Roles } from '@common/decorators';
import { GROUPS, ROLE } from '@common/enums';
import { Controller, Get, Param, Query, Req, SerializeOptions, UseInterceptors } from '@nestjs/common';
import { ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { ListAdvantageSuper } from '../responses/AdvantageSuper';
import { Numerical } from '../responses/Numerical';
import { OrderStatsDate } from '../responses/OrderStatsDate';
import { ResponseTime } from '../responses/ResponseTime';
import { StaticProfits } from '../responses/StaticProfits';
import { StatisticsService } from '../services/statistics.service';
import { WithDeletedInterceptor } from '@common/interceptors';
import { StaticsDriver } from '../responses/statics-driver';
import { StaticsUser } from '../responses/statics-user.interface';

@ApiTags('Statistics')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'statistics', version: '1' })
export class StatisticsController {
  constructor(private staticsService: StatisticsService) {}
  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: Numerical })
  @Get()
  async find() {
    return await this.staticsService.find();
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: ResponseTime })
  @Get('/responseTime')
  async responseTime() {
    return await this.staticsService.responseTime();
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: OrderStatsDate })
  @Get('order')
  findForDate(@Query('first_date') first: string, @Query('second_date') second: string) {
    return this.staticsService.staticsOrdersForDate(first, second);
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: StaticProfits })
  @Get('profits')
  profits(@Query('first_date') first: string, @Query('second_date') second: string) {
    return this.staticsService.staticProfits(first, second);
  }

  @UseInterceptors(WithDeletedInterceptor)
  @SerializeOptions({ groups: [GROUPS.ALL_USERS] })
  @ApiOkResponse({
    isArray: true,
    type: StaticsUser,
  })
  @ApiQuery({
    name: 'page',
    allowEmptyValue: false,
    example: 1,
    required: false,
  })
  @ApiQuery({
    name: 'limit',
    allowEmptyValue: false,
    example: 10,
    required: false,
  })
  @Get('users')
  async staticsUser(
    @Query('page') page: number,
    @Query('limit') limit: number,
    @Req() req: Request & { query: { withDeleted: string } },
  ) {
    const withDeleted = JSON.parse(req.query.withDeleted);
    return this.staticsService.staticsUser(page, limit, withDeleted);
  }

  @UseInterceptors(WithDeletedInterceptor)
  @SerializeOptions({ groups: [GROUPS.ALL_DRIVERS] })
  @ApiOkResponse({ isArray: true, type: StaticsDriver })
  @ApiQuery({
    name: 'page',
    allowEmptyValue: false,
    example: 1,
    required: false,
  })
  @ApiQuery({
    name: 'limit',
    allowEmptyValue: false,
    example: 10,
    required: false,
  })
  @ApiQuery({
    name: 'sort',
    allowEmptyValue: false,
    example: true,
    required: false,
  })
  @Get('drivers')
  async staticsDriver(
    @Query('page') page: number,
    @Query('limit') limit: number,
    @Query('sort') sort: boolean,
    @Req() req: Request & { query: { withDeleted: string } },
  ) {
    const withDeleted = JSON.parse(req.query.withDeleted);
    return this.staticsService.staticsDriver(page, limit, withDeleted, sort);
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: ListAdvantageSuper })
  @Get('advantages/:limit')
  async findLimitAdvantages(@Param('limit') limit: number) {
    return await this.staticsService.findLimitAdvantages(limit);
  }
}
