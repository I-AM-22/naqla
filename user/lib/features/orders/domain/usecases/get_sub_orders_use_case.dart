import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';

@injectable
class GetSubOrdersUseCase extends UseCase<List<SubOrderModel>, GetSubOrdersParam> {
  final OrderRepository _repository;

  GetSubOrdersUseCase(this._repository);
  @override
  FutureResult<List<SubOrderModel>> call(GetSubOrdersParam params) async {
    return _repository.getSubOrders(params);
  }
}

class GetSubOrdersParam {
  final String orderId;

  GetSubOrdersParam({required this.orderId});
}
