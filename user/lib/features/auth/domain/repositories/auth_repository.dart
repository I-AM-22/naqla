import 'package:common_state/common_state.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

import '../../data/model/auth_model.dart';

abstract class AuthRepository {
  FutureResult<String> login(LoginParam param);
  FutureResult<String> signUp(SignUpParam param);
  FutureResult<AuthModel> confirm(ConfirmParam param);
}
