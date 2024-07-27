import { ApiMainErrorsResponse, Auth, GetUser, Id } from '@common/decorators';
import { Controller, Get, Inject, Post } from '@nestjs/common';
import { ApiCreatedResponse, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Payment } from '../entities/payment.entity';
import { HyperPayMethods } from '@common/enums/hyper-pay-method.enum';
import { IPaymentsService } from '../interfaces/services/payments.service.interface';
import { User } from '@models/users/entities/user.entity';
import { PAYMENT_TYPES } from '../interfaces/type';

@ApiTags('Payments')
@ApiMainErrorsResponse()
@Auth()
@Controller({ path: 'payments', version: '1' })
export class PaymentsController {
  constructor(
    @Inject(PAYMENT_TYPES.service)
    private paymentsService: IPaymentsService,
  ) {}

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

  @ApiCreatedResponse({ type: Payment })
  @Post(':id/check-status')
  async checkPaymentStatus(@Id() id: string, @GetUser('id') userId: string) {
    return await this.paymentsService.checkPaymentStatus(id, userId);
  }

  @ApiOkResponse({ type: Payment })
  @Get(':id/recreate')
  async recreate(@Id() id: string, @GetUser() user: User) {
    return await this.paymentsService.recreate(id, user);
  }
}
