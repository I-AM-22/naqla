import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';
import 'package:naqla_driver/features/orders/domain/usecases/set_delivered_use_case.dart';

import '../../../home/data/model/sub_order_model.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImplement implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<SubOrderModel>> getOrdersDone() {
    return toApiResult(
      () => dataSource.getOrdersDone(),
    );
  }

  @override
  FutureResult<List<SubOrderModel>> getActiveOrders() {
    return toApiResult(
      () => dataSource.getActiveOrders(),
    );
  }

  @override
  FutureResult<SubOrderModel> setDelivered(SetDeliveredParam params) {
    return toApiResult(
      () => dataSource.setDelivered(params),
    );
  }

  @override
  FutureResult<SubOrderModel> getSubOrderDetails(String id) {
    return toApiResult(
      () => dataSource.getSubOrderDetails(id),
    );
  }
}
