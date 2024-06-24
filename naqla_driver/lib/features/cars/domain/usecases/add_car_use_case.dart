import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/cars/domain/repositories/cars_repository.dart';

@injectable
class AddCarUseCase extends UseCase<CarModel, AddCarParam> {
  final CarsRepository _repository;

  AddCarUseCase(this._repository);
  @override
  FutureResult<CarModel> call(AddCarParam params) async {
    return _repository.addCar(params);
  }
}

class AddCarParam {
  final String? id;
  final String model;
  final String brand;
  final String color;
  final String photo;
  final List<String> advantages;

  AddCarParam({required this.model, required this.brand, required this.color, required this.photo, required this.advantages, this.id});

  Map<String, dynamic> get toMap => {
        "model": model,
        "brand": brand,
        "color": color,
        "photo": photo,
        "advantages": advantages,
      };
}
