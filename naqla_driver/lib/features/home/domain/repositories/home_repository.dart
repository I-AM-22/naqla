import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/home/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../data/model/car_model.dart';

abstract class HomeRepository {
  FutureResult<CarModel> addCar(AddCarParam params);

  FutureResult<List<CarAdvantage>> getCarAdvantage();
}
