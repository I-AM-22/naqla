import 'package:common_state/common_state.dart';
import 'package:naqla_driver/features/auth/domain/usecases/login_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/signup_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/verification_phone_number_use_case.dart';

import '../../data/model/login_model.dart';

abstract class AuthRepository {
  FutureResult<String> login(LoginParam param);

  FutureResult<String> signUp(SignUpParam param);

  FutureResult<LoginModel> verificationPhoneNumber(VerificationPhoneNumberParam param);
}
