import { ApiMainErrorsResponse, Auth, Roles } from '@common/decorators';
import { ROLE } from '@common/enums';
import { Controller, Get, Param } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { AdvantageSuper } from '../responses/AdvantageSuper';
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
  @Get('order/:first_date/:second_date')
  findForDate(
    @Param('first_date') first: string,
    @Param('second_date') second: string,
  ) {
    return this.staticsService.staticsOrdersForDate(first, second);
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: StaticProfits })
  @Get('profits/:first_date/:second_date')
  profits(
    @Param('first_date') first: string,
    @Param('second_date') second: string,
  ) {
    return this.staticsService.staticProfits(first, second);
  }

  @Roles(ROLE.SUPER_ADMIN, ROLE.ADMIN, ROLE.EMPLOYEE)
  @ApiOkResponse({ isArray: true, type: AdvantageSuper })
  @Get('advantages/:limit')
  async findLimitAdvantages(@Param('limit') limit: number) {
    return await this.staticsService.findLimitAdvantages(limit);
  }
}
