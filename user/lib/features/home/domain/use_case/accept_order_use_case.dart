import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';

@injectable
class AcceptOrderUseCase extends UseCase<OrderModel, AcceptOrderParam> {
  final HomeRepository _repository;

  AcceptOrderUseCase(this._repository);
  @override
  FutureResult<OrderModel> call(AcceptOrderParam params) async {
    return _repository.acceptOrder(params);
  }
}

class AcceptOrderParam {
  final String id;
  final String userId;
  final int cost;

  AcceptOrderParam({required this.id, required this.cost, required this.userId});

  AcceptOrderParam copyWith({String? userId}) => AcceptOrderParam(id: id, cost: cost, userId: userId ?? this.userId);

  Map<String, dynamic> get toMap => {
        "cost": cost,
      };
}
