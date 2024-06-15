import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/use_case/use_case.dart';
import '../../data/model/sub_order_model.dart';
import '../repositories/order_repository.dart';

@injectable
class GetSubOrderDetailsUseCase extends UseCase<SubOrderModel, String> {
  final OrderRepository _repository;

  GetSubOrderDetailsUseCase(this._repository);
  @override
  FutureResult<SubOrderModel> call(String params) async {
    return _repository.getSubOrderDetails(params);
  }
}
