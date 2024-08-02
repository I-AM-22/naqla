import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/features/home/data/model/car_advantage.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/home/domain/use_case/accept_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/set_order_use_case.dart';
import 'package:naqla/features/home/domain/use_case/upload_photos_use_case.dart';
import 'package:http_parser/http_parser.dart' as mime;

@injectable
class HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSource(this.dio);

  Future<List<String>> uploadPhotos(UploadPhotosParam param) {
    return throwAppException(() async {
      List<MultipartFile> files = [];
      for (File? file in param.photos) {
        files.add(await MultipartFile.fromFile(file!.path, contentType: mime.MediaType('image', 'jpeg')));
      }

      Map<String, dynamic> data = {};
      data["photos"] = files;

      FormData formData = FormData.fromMap(data);
      final result = await dio.post(ApiRoutes.multiple, data: formData);
      return List<String>.from(result.data);
    });
  }

  Future<List<CarAdvantage>> getCarAdvantage() {
    return throwAppException(() async {
      final result = await dio.get(ApiRoutes.advantages);
      return (result.data as List<dynamic>).map((e) => CarAdvantage.fromJson(e)).toList();
    });
  }

  Future<List<OrderModel>> getAcceptOrders() {
    return throwAppException(() async {
      final result = await dio.get(ApiRoutes.orderAccepted);
      return (result.data as List<dynamic>).map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  Future<OrderModel> setOrder(SetOrderParam param) {
    return throwAppException(() async {
      final result = await dio.post(ApiRoutes.order, data: param.toMap);
      return OrderModel.fromJson(result.data);
    });
  }

  Future<OrderModel> acceptOrder(AcceptOrderParam param) {
    return throwAppException(() async {
      await dio.patch(ApiRoutes.withDraw(param.userId), data: param.toMap);
      final result = await dio.patch(ApiRoutes.acceptance(param.id));
      return OrderModel.fromJson(result.data);
    });
  }

  Future<OrderModel> cancelOrder(AcceptOrderParam param) {
    return throwAppException(() async {
      final result = await dio.patch(ApiRoutes.cancelOrder(param.id));
      return OrderModel.fromJson(result.data);
    });
  }
}
