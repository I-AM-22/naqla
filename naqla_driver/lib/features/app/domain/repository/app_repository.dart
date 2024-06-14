import 'dart:io';

import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../home/data/model/car_model.dart';

abstract class AppRepository {
  FutureResult<String> uploadImageUseCase(File file);

  FutureResult<List<CarModel>> getAllCars();

  FutureResult<void> deleteCar(String id);

  FutureResult<CarModel> editCar(AddCarParam params);
}
