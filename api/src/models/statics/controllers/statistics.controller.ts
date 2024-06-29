import { ApiMainErrorsResponse, Auth, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { Controller, Get, Param, Query } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { ListAdvantageSuper } from '../responses/AdvantageSuper';
import { Numerical } from '../responses/Numerical';
import { OrderStatsDate } from '../responses/OrderStatsDate';
import { ResponseTime } from '../responses/ResponseTime';
import { StaticProfits } from '../responses/StaticProfits';
import { StatisticsService } from '../services/statistics.service';

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

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ type: ListAdvantageSuper })
  @Get('advantages/:limit')
  async findLimitAdvantages(@Param('limit') limit: number) {
    return await this.staticsService.findLimitAdvantages(limit);
  }
}
