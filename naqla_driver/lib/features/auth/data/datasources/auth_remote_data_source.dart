import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/core/common/constants/configuration/api_routes.dart';
import 'package:naqla_driver/features/auth/data/model/login_model.dart';
import 'package:naqla_driver/features/auth/domain/usecases/login_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/signup_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/verification_phone_number_use_case.dart';

@injectable
class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<String> login(LoginParam param) {
    return throwAppException(() async {
      final result = await dio.post(ApiRoutes.login, data: param.toMap);
      return result.data['message'];
    });
  }

  Future<String> signUp(SignUpParam param) {
    return throwAppException(() async {
      final result = await dio.post(ApiRoutes.signup, data: param.toMap);
      return result.data['message'];
    });
  }

  Future<LoginModel> verificationPhoneNumber(VerificationPhoneNumberParam param) {
    return throwAppException(() async {
      final result = await dio.post(ApiRoutes.confirm, data: param.toMap, queryParameters: {"phoneConfirm": param.phoneConfirm});
      return LoginModel.fromJson(result.data);
    });
  }
}
