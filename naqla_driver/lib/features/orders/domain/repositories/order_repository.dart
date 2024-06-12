import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';

abstract class OrderRepository {
  FutureResult<List<SubOrderModel>> getOrdersDone();
}
