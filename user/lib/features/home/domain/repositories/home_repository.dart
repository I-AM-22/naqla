import 'package:common_state/common_state.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/set_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/upload_photos_use_case.dart';

import '../../data/model/car_advantage.dart';

abstract class HomeRepository {
  FutureResult<List<String>> uploadMultiplePhoto(UploadPhotosParam param);

  FutureResult<List<CarAdvantage>> getCarAdvantages();

  FutureResult<List<OrderModel>> getAcceptOrders();

  FutureResult<OrderModel> setOrder(SetOrderParam param);

  FutureResult<OrderModel> acceptOrder(AcceptOrderParam param);

  FutureResult<OrderModel> cancelOrder(AcceptOrderParam param);
}
