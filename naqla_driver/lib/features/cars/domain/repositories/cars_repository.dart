import 'package:common_state/common_state.dart';

import '../../../home/domain/usecase/add_car_use_case.dart';
import '../../data/model/car_model.dart';

abstract class CarsRepository {
  FutureResult<List<CarModel>> getAllCars();

  FutureResult<void> deleteCar(String id);

  FutureResult<CarModel> editCar(AddCarParam params);
}
