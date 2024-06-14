import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';

import '../../domain/usecases/set_delivered_use_case.dart';
import '../model/sub_two_order_model.dart';

@injectable
class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<List<Sub2OrderModel>> getOrdersDone() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.ordersDone);
        return (result.data as List)
            .map(
              (e) => Sub2OrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<List<Sub2OrderModel>> getOrders() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.subOrders);
        return (result.data as List)
            .map(
              (e) => Sub2OrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<Sub2OrderModel> setDelivered(SetDeliveredParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.setDelivered(params.id));
        return Sub2OrderModel.fromJson(result.data);
      },
    );
  }
}
