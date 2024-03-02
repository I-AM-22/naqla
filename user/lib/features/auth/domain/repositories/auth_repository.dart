import 'package:naqla/core/type_definitions.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

import '../../data/model/auth_model.dart';

abstract class AuthRepository {
  FutureResult<AuthModel> login(LoginParam param);
  FutureResult<String> signUp(SignUpParam param);
  FutureResult<AuthModel> confirm(ConfirmParam param);
}
