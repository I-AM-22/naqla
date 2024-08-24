import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';

import '../repositories/cars_repository.dart';

@injectable
class GetAllCarsUseCase extends UseCase<List<CarModel>, NoParams> {
  final CarsRepository _repository;

  GetAllCarsUseCase(this._repository);
  @override
  FutureResult<List<CarModel>> call(NoParams params) async {
    return _repository.getAllCars();
  }
}
