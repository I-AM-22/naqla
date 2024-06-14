import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';

@injectable
class SetArrivedUseCase extends UseCase<SubOrderModel, SetArrivedParam> {
  final OrderRepository _repository;

  SetArrivedUseCase(this._repository);
  @override
  FutureResult<SubOrderModel> call(SetArrivedParam params) async {
    return _repository.setArrived(params);
  }
}

class SetArrivedParam {
  final String id;

  SetArrivedParam({required this.id});
}
