import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/home/domain/repositories/home_repository.dart';

@injectable
class SetDriverUseCase extends UseCase<bool, SetDriverParam> {
  final HomeRepository _repository;

  SetDriverUseCase(this._repository);
  @override
  FutureResult<bool> call(SetDriverParam params) async {
    return _repository.setDriver(params);
  }
}

class SetDriverParam {
  final String carId;
  final String id;

  SetDriverParam({required this.carId, required this.id});

  Map<String, dynamic> get toMap => {
        "carId": carId,
      };
}
