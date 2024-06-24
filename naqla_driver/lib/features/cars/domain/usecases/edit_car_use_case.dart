import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/domain/usecases/add_car_use_case.dart';

import '../../data/model/car_model.dart';
import '../repositories/cars_repository.dart';

@injectable
class EditCarUseCase extends UseCase<CarModel, AddCarParam> {
  final CarsRepository _repository;

  EditCarUseCase(this._repository);
  @override
  FutureResult<CarModel> call(AddCarParam params) async {
    return _repository.editCar(params);
  }
}
