import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/domain/repositories/cars_repository.dart';

@injectable
class DeleteCarUseCase extends UseCase<void, String> {
  final CarsRepository _repository;

  DeleteCarUseCase(this._repository);
  @override
  FutureResult<void> call(String params) async {
    return _repository.deleteCar(params);
  }
}
