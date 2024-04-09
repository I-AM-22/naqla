import 'package:injectable/injectable.dart';
import 'package:common_state/common_state.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignUpUseCase extends UseCase<String, SignUpParam> {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);
  @override
  FutureResult<String> call(SignUpParam params) async {
    return _repository.signUp(params);
  }
}

class SignUpParam {
  final String phone;
  final String firstName;
  final String lastName;

  SignUpParam({
    required this.phone,
    required this.firstName,
    required this.lastName,
  });
  Map<String, dynamic> get map => {
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
      };
}
