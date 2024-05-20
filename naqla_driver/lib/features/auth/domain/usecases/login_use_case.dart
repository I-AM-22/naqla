import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase extends UseCase<String, LoginParam> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);
  @override
  FutureResult<String> call(LoginParam params) async {
    return _repository.login(params);
  }
}

class LoginParam {
  final String phoneNumber;

  LoginParam({required this.phoneNumber});

  Map<String, dynamic> get toMap => {
        "phone": phoneNumber,
      };
}
