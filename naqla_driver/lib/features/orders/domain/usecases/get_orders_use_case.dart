import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/orders/data/model/sub_two_order_model.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';

@injectable
class GetOrdersUseCase extends UseCase<List<Sub2OrderModel>, NoParams> {
  final OrderRepository _repository;

  GetOrdersUseCase(this._repository);
  @override
  FutureResult<List<Sub2OrderModel>> call(NoParams params) async {
    return _repository.getOrders();
  }
}
