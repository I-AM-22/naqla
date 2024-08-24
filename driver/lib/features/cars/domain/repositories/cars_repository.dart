import 'package:common_state/common_state.dart';

import '../usecases/add_car_use_case.dart';
import '../../data/model/car_model.dart';
import '../usecases/edit_car_use_case.dart';

abstract class CarsRepository {
  FutureResult<List<CarModel>> getAllCars();

  FutureResult<CarModel> addCar(AddCarParam params);

  FutureResult<void> deleteCar(String id);

  FutureResult<CarModel> editCar(EditCarParam params);
}
