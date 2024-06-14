import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:http_parser/http_parser.dart' as mime;
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../../core/api/api_utils.dart';
import '../../../../core/common/constants/configuration/api_routes.dart';

@injectable
class AppRemoteDataSource {
  final Dio dio;

  AppRemoteDataSource(this.dio);

  Future<String> uploadImage(File file) {
    return throwAppException(
      () async {
        Map<String, dynamic> data = {};
        data["photo"] = await MultipartFile.fromFile(file.path, contentType: mime.MediaType('image', 'jpeg'));

        FormData formData = FormData.fromMap(data);
        final result = await dio.post(ApiRoutes.single, data: formData);
        return result.data;
      },
    );
  }

  Future<List<CarModel>> getAllCars() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.carsMine);
        return (result.data as List)
            .map(
              (e) => CarModel.fromJson(e),
            )
            .toList();
      },
    );
  }

  Future<void> deleteCar(String id) {
    return throwAppException(
      () async {
        await dio.delete(ApiRoutes.deleteCar(id));
      },
    );
  }

  Future<CarModel> editCar(AddCarParam params) {
    return throwAppException(
      () async {
        final result = await dio.patch(ApiRoutes.editCar(params.id!), data: params.toMap);
        return CarModel.fromJson(result.data);
      },
    );
  }
}
