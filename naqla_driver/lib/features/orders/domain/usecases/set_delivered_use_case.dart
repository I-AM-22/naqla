import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/orders/domain/repositories/order_repository.dart';

import '../../../home/data/model/sub_order_model.dart';

@injectable
class SetDeliveredUseCase extends UseCase<SubOrderModel, SetDeliveredParam> {
  final OrderRepository _repository;

  SetDeliveredUseCase(this._repository);
  @override
  FutureResult<SubOrderModel> call(SetDeliveredParam params) async {
    return _repository.setDelivered(params);
  }
}

class SetDeliveredParam {
  final String id;

  SetDeliveredParam({required this.id});
}
