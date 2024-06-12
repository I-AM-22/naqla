import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/app/domain/repository/app_repository.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';

@injectable
class GetAllCarsUseCase extends UseCase<List<CarModel>, NoParams> {
  final AppRepository _repository;

  GetAllCarsUseCase(this._repository);
  @override
  FutureResult<List<CarModel>> call(NoParams params) async {
    return _repository.getAllCars();
  }
}
