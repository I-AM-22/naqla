import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/home/data/datasource/home_remote_data_source.dart';
import 'package:naqla_driver/features/cars/data/model/car_advantage.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/repositories/home_repository.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImplement implements HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImplement(this.dataSource);

  @override
  FutureResult<List<CarAdvantage>> getCarAdvantage() {
    return toApiResult(
      () => dataSource.getCarAdvantage(),
    );
  }

  @override
  FutureResult<List<SubOrderModel>> getSubOrders() {
    return toApiResult(
      () => dataSource.getSubOrders(),
    );
  }

  @override
  FutureResult<bool> setDriver(SetDriverParam params) {
    return toApiResult(
      () => dataSource.setDriver(params),
    );
  }

  @override
  FutureResult<List<CarModel>> getOrderCar(String params) {
    return toApiResult(
      () => dataSource.getOrderCars(params),
    );
  }
}
