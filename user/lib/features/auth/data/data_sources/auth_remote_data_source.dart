import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/common/constants/configuration/uri_routs.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

import '../../../../core/api/api_utils.dart';

@injectable
class AuthRemoteDataSource {
  final Dio _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<AuthModel> login(LoginParam param) async {
    return throwAppException(() async {
      final result =
          await _dioClient.post(EndPoints.auth.login, data: param.map);
      return AuthModel.fromJson(result.data);
    });
  }

  Future<AuthModel> signUp(SignUpParam param) async {
    return throwAppException(() async {
      final result =
          await _dioClient.post(EndPoints.auth.signup, data: param.map);
      return AuthModel.fromJson(result.data);
    });
  }
}
