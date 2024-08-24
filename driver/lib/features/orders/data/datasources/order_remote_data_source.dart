import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../../domain/usecases/set_delivered_use_case.dart';

@injectable
class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<List<SubOrderModel>> getOrdersDone() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.ordersDone);
        return (result.data as List)
            .map(
              (e) => SubOrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<List<SubOrderModel>> getActiveOrders() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.activeOrders);
        return (result.data as List)
            .map(
              (e) => SubOrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<SubOrderModel> setDelivered(SetDeliveredParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.setDelivered(params.id));
        return SubOrderModel.fromJson(result.data);
      },
    );
  }

  Future<SubOrderModel> getSubOrderDetails(String params) {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.subOrderDetails(params));
        return SubOrderModel.fromJson(result.data);
      },
    );
  }
}
