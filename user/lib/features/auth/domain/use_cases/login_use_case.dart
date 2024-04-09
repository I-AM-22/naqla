import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase extends UseCase<String, LoginParam> {
  final AuthRepository repository;

  LoginUseCase(this.repository);
  @override
  FutureResult<String> call(LoginParam params) async {
    return repository.login(params);
  }
}

class LoginParam {
  final String phoneNumber;

  LoginParam(
    this.phoneNumber,
  );

  Map<String, dynamic> get map => {
        "phone": phoneNumber,
      };
}
