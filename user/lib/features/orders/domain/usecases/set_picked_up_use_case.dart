import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';

@injectable
class SetPickedUpUseCase extends UseCase<SubOrderModel, SetArrivedParam> {
  final OrderRepository _repository;

  SetPickedUpUseCase(this._repository);
  @override
  FutureResult<SubOrderModel> call(SetArrivedParam params) async {
    return _repository.setPickedUp(params);
  }
}
