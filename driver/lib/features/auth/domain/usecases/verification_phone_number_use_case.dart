import 'package:common_state/common_state.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/auth/data/model/login_model.dart';
import 'package:naqla_driver/features/auth/domain/repositories/auth_repository.dart';

@injectable
class VerificationPhoneNumberUseCase extends UseCase<LoginModel, VerificationPhoneNumberParam> {
  final AuthRepository _repository;

  VerificationPhoneNumberUseCase(this._repository);
  @override
  FutureResult<LoginModel> call(VerificationPhoneNumberParam params) async {
    return _repository.verificationPhoneNumber(params);
  }
}

class VerificationPhoneNumberParam {
  final String otp;
  final String phone;
  final bool phoneConfirm;

  VerificationPhoneNumberParam({required this.otp, required this.phone, this.phoneConfirm = false});

  Map<String, dynamic> get toMap => {
        "otp": otp,
        "phone": phone,
      };
}
