import { HyperPayMethods } from '@common/enums/hyper-pay-method.enum';
import { Order } from '@models/orders/entities/order.entity';
import { Payment } from '@models/payments/entities/payment.entity';
import { User } from '@models/users/entities/user.entity';

export interface IPaymentsService {
  create(order: Order, sum: number): Promise<Payment>;

  findById(id: string): Promise<Payment>;

  fineOneByOrderId(orderId: string): Promise<Payment>;

  setTotal(orderId: string, cost: number): Promise<Payment>;

  setDeliveredDate(orderId: string): Promise<Payment>;

  checkPaymentStatus(id: string, userId: string): Promise<Payment>;

  createCheckout(payment: Payment, methodType: HyperPayMethods, user: User): Promise<Payment>;

  recreate(id: string, user: User): Promise<Payment>;
}
