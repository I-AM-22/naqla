import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/repositories/home_repository.dart';

@injectable
class GetSubOrdersUseCase extends UseCase<List<SubOrderModel>, NoParams> {
  final HomeRepository _repository;

  GetSubOrdersUseCase(this._repository);
  @override
  FutureResult<List<SubOrderModel>> call(NoParams params) async {
    return _repository.getSubOrders();
  }
}
