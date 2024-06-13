import 'package:common_state/common_state.dart';

import '../../data/model/sub_two_order_model.dart';

abstract class OrderRepository {
  FutureResult<List<Sub2OrderModel>> getOrdersDone();

  FutureResult<List<Sub2OrderModel>> getOrders();
}
