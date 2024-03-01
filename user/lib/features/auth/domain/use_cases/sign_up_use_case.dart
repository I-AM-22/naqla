import 'package:injectable/injectable.dart';
import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignUpUseCase extends UseCase<AuthModel, SignUpParam> {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);
  @override
  FutureResult<AuthModel> call(SignUpParam params) async {
    return _repository.signUp(params);
  }
}

class SignUpParam {
  final String phone;
  final String firstName;
  final String lastName;
  final String password;

  SignUpParam(
      {required this.phone,
      required this.firstName,
      required this.lastName,
      required this.password});
  Map<String, dynamic> get map => {
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
        "password": password,
      };
}
