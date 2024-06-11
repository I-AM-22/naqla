import { Order } from '@models/orders/entities/order.entity';
import { Payment } from '@models/payments/entities/payment.entity';

export interface IPaymentRepository {
  create(order: Order, sum: number): Promise<Payment>;

  setTotal(id: string, cost: number): Promise<Payment>;

  setDeliveredDate(id: string): Promise<Payment>;
}
