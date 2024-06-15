import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';

import '../../../home/data/model/sub_order_model.dart';

@injectable
class GetOrdersDoneUseCase extends UseCase<List<SubOrderModel>, NoParams> {
  final OrderRepository _repository;

  GetOrdersDoneUseCase(this._repository);
  @override
  FutureResult<List<SubOrderModel>> call(NoParams params) async {
    return _repository.getOrdersDone();
  }
}
