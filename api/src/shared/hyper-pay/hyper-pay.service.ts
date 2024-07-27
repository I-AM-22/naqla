import { HyperPayMethods } from '@common/enums/hyper-pay-method.enum';
import HyperPayConfig from '@config/hyper-pay/hyper-pay.config';
import { User } from '@models/users/entities/user.entity';
import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { ConfigType } from '@nestjs/config';
import axios from 'axios';
import { ApiResponse } from '.';

@Injectable()
export class HyperPayService {
  constructor(
    @Inject(HyperPayConfig.KEY)
    private readonly hyperPayConfig: ConfigType<typeof HyperPayConfig>,
  ) {}

  async createCheckout(amount: number, entityType: string, paymentId: string, user: User): Promise<ApiResponse> {
    const url = this.hyperPayConfig.api;
    let entityId = this.hyperPayConfig.madaEntityId;

    if (entityType === HyperPayMethods.mada) {
      entityId = this.hyperPayConfig.madaEntityId;
    } else if (entityType === HyperPayMethods.visa || entityType === HyperPayMethods.master) {
      entityId = this.hyperPayConfig.vmEntityId;
    }

    const data = {
      merchantTransactionId: paymentId,
      entityId,
      amount: amount.toString(),
      currency: this.hyperPayConfig.currency,
      paymentType: this.hyperPayConfig.paymentType,
      'customer.givenName': user.firstName,
      'customer.surname': user.lastName,
    };

    const options = {
      headers: {
        Authorization: `Bearer ${this.hyperPayConfig.accessToken}`,
      },
      params: data,
    };

    try {
      const response = await axios.post<ApiResponse>(url, data, options);
      return response.data;
    } catch (error) {
      console.log(error);
      throw new BadRequestException('Failed to create a checkout');
    }
  }

  async checkPaymentStatus(checkoutId: string, entityType: string): Promise<ApiResponse> {
    let entityId = this.hyperPayConfig.madaEntityId;

    if (entityType === HyperPayMethods.mada) {
      entityId = this.hyperPayConfig.madaEntityId;
    } else if (entityType === HyperPayMethods.visa || entityType === HyperPayMethods.master) {
      entityId = this.hyperPayConfig.vmEntityId;
    }

    const url = `${this.hyperPayConfig.api}/${checkoutId}/payment?entityId=${entityId}`;
    const options = {
      headers: { Authorization: `Bearer ${this.hyperPayConfig.accessToken}` },
    };

    try {
      const response = await axios.get<ApiResponse>(url, options);
      return response.data;
    } catch (error) {
      throw new BadRequestException('Failed to get payment status');
    }
  }
}
