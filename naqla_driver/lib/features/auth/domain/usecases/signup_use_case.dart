import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/auth/domain/repositories/auth_repository.dart';

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
  final String firstName;
  final String lastName;
  final String phoneNumber;

  SignUpParam({required this.firstName, required this.lastName, required this.phoneNumber});

  Map<String, dynamic> get toMap => {
        "phone": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
      };
}
