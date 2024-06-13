import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class GetAcceptOrdersUseCase extends UseCase<List<OrderModel>, NoParams> {
  final HomeRepository _repository;

  GetAcceptOrdersUseCase(this._repository);
  @override
  FutureResult<List<OrderModel>> call(NoParams params) async {
    return _repository.getAcceptOrders();
  }
}
