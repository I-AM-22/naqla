import 'package:common_state/common_state.dart';

import '../../data/model/sub_two_order_model.dart';
import '../usecases/set_delivered_use_case.dart';

abstract class OrderRepository {
  FutureResult<List<Sub2OrderModel>> getOrdersDone();

  FutureResult<List<Sub2OrderModel>> getOrders();

  FutureResult<Sub2OrderModel> setDelivered(SetDeliveredParam params);
}
