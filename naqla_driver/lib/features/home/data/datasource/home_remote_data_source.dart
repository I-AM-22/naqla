import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';
import 'package:naqla_driver/features/cars/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import '../../../cars/data/model/car_model.dart';

@injectable
class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<List<CarAdvantage>> getCarAdvantage() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.advantages);
        return (result.data as List)
            .map(
              (e) => CarAdvantage.fromJson(e, false),
            )
            .toList();
      },
    );
  }

  Future<List<SubOrderModel>> getSubOrders() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.subOrdersForDriver);
        return (result.data as List)
            .map(
              (e) => SubOrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<List<CarModel>> getOrderCars(String params) {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.getOrderCars(params));
        return (result.data as List)
            .map(
              (e) => CarModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<bool> setDriver(SetDriverParam params) {
    return throwAppException(
      () async {
        await dio.patch(ApiRoutes.setDriver(params.id), data: params.toMap);
        return true;
      },
    );
  }
}
