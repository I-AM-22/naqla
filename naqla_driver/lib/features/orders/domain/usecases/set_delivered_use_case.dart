import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/orders/data/model/sub_two_order_model.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';

@injectable
class SetDeliveredUseCase extends UseCase<Sub2OrderModel, SetDeliveredParam> {
  final OrderRepository _repository;

  SetDeliveredUseCase(this._repository);
  @override
  FutureResult<Sub2OrderModel> call(SetDeliveredParam params) async {
    return _repository.setDelivered(params);
  }
}

class SetDeliveredParam {
  final String id;

  SetDeliveredParam({required this.id});
}
