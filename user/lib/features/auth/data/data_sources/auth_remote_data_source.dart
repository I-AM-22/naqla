import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/common/constants/configuration/api_routes.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

import '../../../../core/api/api_utils.dart';

@injectable
class AuthRemoteDataSource {
  final Dio _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<String> login(LoginParam param) async {
    return throwAppException(() async {
      final result = await _dioClient.post(ApiRoutes.login, data: param.map);
      return result.data['message'];
    });
  }

  Future<String> signUp(SignUpParam param) async {
    return throwAppException(() async {
      final result = await _dioClient.post(ApiRoutes.signup, data: param.map);
      return result.data['message'];
    });
  }

  Future<AuthModel> confirm(ConfirmParam param) async {
    return throwAppException(() async {
      final result = await _dioClient.post(ApiRoutes.confirm,
          data: param.map,
          queryParameters: {'phoneConfirm': param.phoneConfirm});
      await getIt<PrefsRepository>().setToken(result.data['token']);
      return AuthModel.fromJson(result.data);
    });
  }
}
