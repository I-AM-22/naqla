import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/api/api_utils.dart';
import 'package:naqla/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImplement(this._dataSource);
  @override
  FutureResult<String> login(LoginParam param) {
    return toApiResult(() async => _dataSource.login(param));
  }

  @override
  FutureResult<String> signUp(SignUpParam param) {
    return toApiResult(() async => _dataSource.signUp(param));
  }

  @override
  FutureResult<AuthModel> confirm(ConfirmParam param) {
    return toApiResult(() async => _dataSource.confirm(param));
  }
}
