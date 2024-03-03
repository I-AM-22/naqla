import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/uri_routs.dart';

import '../../../auth/data/model/auth_model.dart';
import 'package:http_parser/http_parser.dart' as mime;

import '../../domain/use_cases/edit_personal_info_use_case.dart';
import '../../domain/use_cases/upload_single_photo_use_case.dart';

@injectable
class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<User> getPersonalInfo() {
    return throwAppException(() async {
      final result = await dio.get(EndPoints.profile.personalInfo);
      return User.fromJson(result.data);
    });
  }

  Future<User> editPersonalInfo(EditPersonalInfoParam param) {
    return throwAppException(() async {
      final result =
          await dio.patch(EndPoints.profile.personalInfo, data: param.map);
      return User.fromJson(result.data);
    });
  }

  Future<String> uploadSinglePhoto(UploadSinglePhotoParam param) {
    return throwAppException(() async {
      FormData formData = FormData.fromMap({
        'photo': MultipartFile.fromFileSync(param.file.path,
            contentType: mime.MediaType('image', 'jpeg'))
      });
      final result = await dio.post(EndPoints.photo.single, data: formData);
      return result.data;
    });
  }
}
