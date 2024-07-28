import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/features/home/data/data_source/home_remote_data_source.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/repositories/home_repository.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/set_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/upload_photos_use_case.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImplement extends HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImplement(this.dataSource);
  @override
  FutureResult<List<String>> uploadMultiplePhoto(UploadPhotosParam param) {
    return toApiResult(() => dataSource.uploadPhotos(param));
  }

  @override
  FutureResult<List<CarAdvantage>> getCarAdvantages() {
    return toApiResult(() => dataSource.getCarAdvantage());
  }

  @override
  FutureResult<List<OrderModel>> getAcceptOrders() {
    return toApiResult(() => dataSource.getAcceptOrders());
  }

  @override
  FutureResult<OrderModel> setOrder(SetOrderParam param) {
    return toApiResult(() => dataSource.setOrder(param));
  }

  @override
  FutureResult<OrderModel> acceptOrder(AcceptOrderParam param) {
    return toApiResult(
      () => dataSource.acceptOrder(param),
    );
  }

  @override
  FutureResult<OrderModel> cancelOrder(AcceptOrderParam param) {
    return toApiResult(
      () => dataSource.cancelOrder(param),
    );
  }
}
