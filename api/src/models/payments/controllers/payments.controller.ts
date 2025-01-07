import { ApiMainErrorsResponse, Auth, Id } from '@common/decorators';
import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Payment } from '../entities/payment.entity';
import { HyperPayMethods } from '@common/enums/hyper-pay-method.enum';
import { PaymentsService } from '../services/payments.service';

@ApiTags('Payments')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'payments', version: '1' })
export class PaymentsController {
  constructor(private paymentsService: PaymentsService) {}

  @ApiOkResponse({
    isArray: true,
    schema: { example: Object.values(HyperPayMethods) },
  })
  @Get('payment-methods')
  async findPaymentMethods() {
    return Object.values(HyperPayMethods);
  }

  @ApiOkResponse({ type: Payment })
  @Get(':id')
  async findOne(@Id() id: string) {
    return await this.paymentsService.findById(id);
  }

  // @ApiCreatedResponse({ type: Payment })
  // @Post(':id/check-status')
  // async checkPaymentStatus(@Id() id: string, @GetUser('id') userId: string) {
  //   return await this.paymentsService.checkPaymentStatus(id, userId);
  // }

  // @ApiOkResponse({ type: Payment })
  // @Get(':id/recreate')
  // async recreate(@Id() id: string, @GetUser() user: User) {
  //   return await this.paymentsService.recreate(id, user);
  // }
}
