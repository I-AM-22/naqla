import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';

import '../../data/model/car_model.dart';
import '../repositories/cars_repository.dart';

@injectable
class EditCarUseCase extends UseCase<CarModel, EditCarParam> {
  final CarsRepository _repository;

  EditCarUseCase(this._repository);
  @override
  FutureResult<CarModel> call(EditCarParam params) async {
    return _repository.editCar(params);
  }
}

class EditCarParam {
  final String? id;
  final String model;
  final String brand;
  final String color;
  final String? photo;
  final List<String> advantages;

  EditCarParam({required this.model, required this.brand, required this.color, required this.photo, required this.advantages, this.id});

  Map<String, dynamic> get toMap => {
        "model": model,
        "brand": brand,
        "color": color,
        "photo": photo,
        'advantageIds': advantages,
      }..removeWhere(
          (key, value) => value == null,
        );
}
