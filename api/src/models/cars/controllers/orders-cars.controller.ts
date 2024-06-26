import { Controller, Get, Inject, SerializeOptions, UseInterceptors } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { LoggingInterceptor } from '@common/interceptors';
import { ApiMainErrorsResponse, Auth, GetUser, Id, Roles } from '@common/decorators';
import { CAR_TYPES } from '../interfaces/type';
import { ICarsService } from '../interfaces/services/cars.service.interface';
import { GROUPS, ROLE } from '@common/enums';
import { Car } from '../entities/car.entity';

@ApiTags('Cars')
@ApiMainErrorsResponse()
@UseInterceptors(new LoggingInterceptor())
@Auth()
@Controller({ path: 'orders/:id/cars', version: '1' })
export class OrderCarController {
  constructor(@Inject(CAR_TYPES.service) private readonly carsService: ICarsService) {}
  @SerializeOptions({ groups: [GROUPS.ALL_CARS] })
  @Roles(ROLE.DRIVER)
  @ApiOkResponse({ type: Car, isArray: true })
  @Get('/mine')
  async findMineForOrder(@GetUser('id') driverId: string, @Id() orderId: string): Promise<Car[]> {
    return this.carsService.findMyCarsForOrder(driverId, orderId);
  }
}
