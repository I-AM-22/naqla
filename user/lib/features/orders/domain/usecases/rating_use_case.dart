import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/repositories/order_repository.dart';

@injectable
class RatingUseCase extends UseCase<SubOrderModel, RatingParam> {
  final OrderRepository _repository;

  RatingUseCase(this._repository);

  @override
  FutureResult<SubOrderModel> call(RatingParam params) async {
    return _repository.rating(params);
  }
}

class RatingParam {
  final String id;
  final int rating;
  final String notes;
  final bool repeatDriver;

  RatingParam({
    required this.id,
    required this.rating,
    required this.notes,
    required this.repeatDriver,
  });

  Map<String, dynamic> get toMap => {
        "rating": rating,
        "note": notes,
        "repeatDriver": repeatDriver,
      };
}
