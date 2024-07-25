import 'package:common_state/common_state.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../usecases/set_delivered_use_case.dart';

abstract class OrderRepository {
  FutureResult<List<SubOrderModel>> getOrdersDone();

  FutureResult<List<SubOrderModel>> getActiveOrders();

  FutureResult<SubOrderModel> setDelivered(SetDeliveredParam params);

  FutureResult<SubOrderModel> getSubOrderDetails(String id);
}
