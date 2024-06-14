import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_sub_orders_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';

@injectable
class OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSource(this.dio);

  Future<List<OrderModel>> getOrders() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.orderMine);
        return (result.data as List)
            .map(
              (e) => OrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<List<SubOrderModel>> getSubOrders(GetSubOrdersParam params) {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.subOrders(params.orderId));
        return (result.data as List)
            .map(
              (e) => SubOrderModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<SubOrderModel> setArrived(SetArrivedParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.setArrived(params.id));
        return SubOrderModel.fromJson(result.data);
      },
    );
  }

  Future<SubOrderModel> setPickedUp(SetArrivedParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.setPickedUp(params.id));
        return SubOrderModel.fromJson(result.data);
      },
    );
  }
}
