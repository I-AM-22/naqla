import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class GetOrdersUseCase extends UseCase<List<OrderModel>, NoParams> {
  final HomeRepository _repository;

  GetOrdersUseCase(this._repository);
  @override
  FutureResult<List<OrderModel>> call(NoParams params) async {
    return _repository.getOrders();
  }
}
