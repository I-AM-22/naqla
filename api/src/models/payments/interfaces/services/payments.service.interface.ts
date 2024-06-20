import { Order } from '@models/orders/entities/order.entity';
import { Payment } from '@models/payments/entities/payment.entity';

export interface IPaymentsService {
  create(order: Order, sum: number): Promise<Payment>;

  fineOneByOrderId(orderId: string): Promise<Payment>;

  setTotal(orderId: string, cost: number): Promise<Payment>;

  setDeliveredDate(orderId: string): Promise<Payment>;
}
