import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';

import '../model/sub_two_order_model.dart';

@Injectable(as: OrderRepository)
class OrderRepositoryImplement implements OrderRepository {
  final OrderRemoteDataSource dataSource;

  OrderRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<Sub2OrderModel>> getOrdersDone() {
    return toApiResult(
      () => dataSource.getOrdersDone(),
    );
  }

  @override
  FutureResult<List<Sub2OrderModel>> getOrders() {
    return toApiResult(
      () => dataSource.getOrders(),
    );
  }
}
