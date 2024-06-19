import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/cars/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import '../../../cars/data/model/car_model.dart';

abstract class HomeRepository {
  FutureResult<CarModel> addCar(AddCarParam params);

  FutureResult<List<CarAdvantage>> getCarAdvantage();

  FutureResult<List<SubOrderModel>> getSubOrders();

  FutureResult<void> setDriver(SetDriverParam params);

  FutureResult<List<CarModel>> getOrderCar(String params);
}
