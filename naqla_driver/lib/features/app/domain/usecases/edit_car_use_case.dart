import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/app/domain/repository/app_repository.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

@injectable
class EditCarUseCase extends UseCase<CarModel, AddCarParam> {
  final AppRepository _repository;

  EditCarUseCase(this._repository);
  @override
  FutureResult<CarModel> call(AddCarParam params) async {
    return _repository.editCar(params);
  }
}
