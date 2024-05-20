import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/api/api_utils.dart';
import 'package:naqla_driver/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:naqla_driver/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:naqla_driver/features/auth/data/model/login_model.dart';
import 'package:naqla_driver/features/auth/domain/repositories/auth_repository.dart';
import 'package:naqla_driver/features/auth/domain/usecases/login_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/signup_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/verification_phone_number_use_case.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  final AuthLocaleDataSource localDataSource;

  AuthRepositoryImplement(this.dataSource, this.localDataSource);
  @override
  FutureResult<String> login(LoginParam param) {
    return toApiResult(() async => await dataSource.login(param));
  }

  @override
  FutureResult<String> signUp(SignUpParam param) {
    return toApiResult(() async => await dataSource.signUp(param));
  }

  @override
  FutureResult<LoginModel> verificationPhoneNumber(VerificationPhoneNumberParam param) {
    return toApiResult(() async {
      final result = await dataSource.verificationPhoneNumber(param);
      await localDataSource.cachedDriverInfo(result);
      return result;
    });
  }
}
