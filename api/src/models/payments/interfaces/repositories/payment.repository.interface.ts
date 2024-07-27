import { Order } from '@models/orders/entities/order.entity';
import { Payment } from '@models/payments/entities/payment.entity';

export interface IPaymentRepository {
  create(order: Order, sum: number): Promise<Payment>;

  findById(id: string): Promise<Payment>;

  fineOneByOrderId(orderId: string): Promise<Payment>;

  setTotal(payment: Payment, cost: number): Promise<Payment>;

  setDeliveredDate(payment: Payment): Promise<Payment>;
}
