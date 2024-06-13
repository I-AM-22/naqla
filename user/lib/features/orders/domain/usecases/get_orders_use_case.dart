import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';

@injectable
class GetOrdersUseCase extends UseCase<List<OrderModel>, NoParams> {
  final OrderRepository _repository;

  GetOrdersUseCase(this._repository);
  @override
  FutureResult<List<OrderModel>> call(NoParams params) async {
    return _repository.getOrders();
  }
}
