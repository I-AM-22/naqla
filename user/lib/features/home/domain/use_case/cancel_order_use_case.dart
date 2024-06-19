import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';

@injectable
class CancelOrderUseCase extends UseCase<OrderModel, AcceptOrderParam> {
  final HomeRepository _repository;

  CancelOrderUseCase(this._repository);
  @override
  FutureResult<OrderModel> call(AcceptOrderParam params) async {
    return _repository.cancelOrder(params);
  }
}
