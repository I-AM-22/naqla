import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/rating_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImplement implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<OrderModel>> getActiveOrders() {
    return toApiResult(
      () => dataSource.getActiveOrders(),
    );
  }

  @override
  FutureResult<List<SubOrderModel>> getSubOrders(GetSubOrdersParam params) {
    return toApiResult(
      () => dataSource.getSubOrders(params),
    );
  }

  @override
  FutureResult<SubOrderModel> setArrived(SetArrivedParam params) {
    return toApiResult(
      () => dataSource.setArrived(params),
    );
  }

  @override
  FutureResult<SubOrderModel> setPickedUp(SetArrivedParam params) {
    return toApiResult(
      () => dataSource.setPickedUp(params),
    );
  }

  @override
  FutureResult<SubOrderModel> getSubOrderDetails(String id) {
    return toApiResult(
      () => dataSource.getSubOrderDetails(id),
    );
  }

  @override
  FutureResult<List<OrderModel>> getDoneOrders() {
    return toApiResult(
      () => dataSource.getDoneOrders(),
    );
  }

  @override
  FutureResult<SubOrderModel> rating(RatingParam params) {
    return toApiResult(
      () => dataSource.rating(params),
    );
  }
}
