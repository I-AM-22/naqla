import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';

import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final ConfirmUseCase _confirmUseCase;
  AuthBloc(this._loginUseCase, this._signUpUseCase, this._confirmUseCase) : super(AuthState()) {
    multiStateApiCall<LoginEvent, String>(
      AuthState.login,
      (event) => _loginUseCase(event.param),
      onSuccess: (data, event, emit) async => event.onSuccess(data),
    );

    multiStateApiCall<SignUpEvent, String>(
      AuthState.signUp,
      (event) => _signUpUseCase(event.param),
      onSuccess: (data, event, emit) async => event.onSuccess(data),
    );

    multiStateApiCall<ConfirmEvent, AuthModel>(
      AuthState.confirm,
      (event) => _confirmUseCase(event.param),
      onSuccess: (data, event, emit) async {
        getIt<PrefsRepository>().setUser(data.user);
        return event.onSuccess(data);
      },
    );
  }
}
