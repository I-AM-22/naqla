import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:http_parser/http_parser.dart' as mime;

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
}
