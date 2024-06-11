import 'dart:io';

import 'package:common_state/common_state.dart';

import '../../../home/data/model/car_model.dart';

abstract class AppRepository {
  FutureResult<String> uploadImageUseCase(File file);

  FutureResult<List<CarModel>> getAllCars();
}
