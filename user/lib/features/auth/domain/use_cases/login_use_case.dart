import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';

@injectable
class LoginUseCase extends UseCase<AuthModel, LoginParam> {
  final AuthRepository repository;

  LoginUseCase(this.repository);
  @override
  FutureResult<AuthModel> call(LoginParam params) async {
    return repository.login(params);
  }
}

class LoginParam {
  final String phoneNumber;
  final String password;

  LoginParam(this.phoneNumber, this.password);

  Map<String, dynamic> get map => {"phone": phoneNumber, "password": password};
}
