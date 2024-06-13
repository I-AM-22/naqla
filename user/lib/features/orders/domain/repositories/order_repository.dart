import 'package:common_state/common_state.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';

abstract class OrderRepository {
  FutureResult<List<OrderModel>> getOrders();

  FutureResult<List<SubOrderModel>> getSubOrders(GetSubOrdersParam params);
}
