import 'package:common_state/common_state.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/rating_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';

abstract class OrderRepository {
  FutureResult<List<OrderModel>> getActiveOrders();

  FutureResult<List<OrderModel>> getDoneOrders();

  FutureResult<List<SubOrderModel>> getSubOrders(GetSubOrdersParam params);

  FutureResult<SubOrderModel> setArrived(SetArrivedParam params);

  FutureResult<SubOrderModel> setPickedUp(SetArrivedParam params);

  FutureResult<SubOrderModel> getSubOrderDetails(String id);

  FutureResult<SubOrderModel> rating(RatingParam params);
}
