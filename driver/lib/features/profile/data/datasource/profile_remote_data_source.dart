import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';

import '../../../auth/data/model/driver_model.dart';
import '../../domain/usecases/edit_personal_info_use_case.dart';
import 'package:http_parser/http_parser.dart' as mime;
import '../../domain/usecases/upload_single_photo_use_case.dart';

@injectable
class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<DriverModel> getProfile() {
    return throwAppException(
      () async {
        final result = await dio.get(ApiRoutes.myProfile);
        return DriverModel.fromJson(result.data);
      },
    );
  }

  Future<DriverModel> editPersonalInfo(EditPersonalInfoParam param) {
    return throwAppException(() async {
      final result = await dio.patch(ApiRoutes.myProfile, data: param.map);
      return DriverModel.fromJson(result.data);
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
        ApiRoutes.myProfile,
      );
    });
  }
}
