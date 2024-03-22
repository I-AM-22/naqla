import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';

import 'package:http_parser/http_parser.dart' as mime;

import '../../../auth/data/model/user_model.dart';
import '../../domain/use_cases/edit_personal_info_use_case.dart';
import '../../domain/use_cases/upload_single_photo_use_case.dart';

@injectable
class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<User> getPersonalInfo() {
    return throwAppException(() async {
      final result = await dio.get(ApiRoutes.personalInfo);
      return User.fromJson(result.data);
    });
  }

  Future<User> editPersonalInfo(EditPersonalInfoParam param) {
    return throwAppException(() async {
      final result = await dio.patch(ApiRoutes.personalInfo, data: param.map);
      return User.fromJson(result.data);
    });
  }

  Future<String> uploadSinglePhoto(UploadSinglePhotoParam param) {
    return throwAppException(() async {
      FormData formData = FormData.fromMap({'photo': MultipartFile.fromFileSync(param.file.path, contentType: mime.MediaType('image', 'jpeg'))});
      final result = await dio.post(ApiRoutes.single, data: formData);
      return result.data;
    });
  }

  Future<String> updatePhoneNumber(String param) {
    return throwAppException(() async {
      final result = await dio.patch(ApiRoutes.updateMyNumber, data: {'phone': param});
      return result.data['message'];
    });
  }

  Future<void> deleteAccount() {
    return throwAppException(() async {
      await dio.delete(
        ApiRoutes.personalInfo,
      );
    });
  }
}
