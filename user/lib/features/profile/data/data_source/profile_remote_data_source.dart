import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/core/common/constants/configuration/uri_routs.dart';

import '../../../auth/data/model/auth_model.dart';

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
}
