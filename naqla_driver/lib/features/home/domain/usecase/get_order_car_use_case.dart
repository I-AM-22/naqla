import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/repositories/home_repository.dart';

@injectable
class GetOrderCarUseCase extends UseCase<List<CarModel>, String> {
  final HomeRepository _repository;

  GetOrderCarUseCase(this._repository);
  @override
  FutureResult<List<CarModel>> call(String params) async {
    return _repository.getOrderCar(params);
  }
}
