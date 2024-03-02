import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/util/core_helper_functions.dart';

import 'package:naqla/features/auth/data/model/auth_model.dart';
import 'package:naqla/features/auth/domain/use_cases/confirm_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/login_use_case.dart';
import 'package:naqla/features/auth/domain/use_cases/sign_up_use_case.dart';

import '../../../../../core/state_managment/state/common_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@LazySingleton()
class AuthBloc extends Bloc<AuthEvent, Map<int, CommonState>> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final ConfirmUseCase _confirmUseCase;
  AuthBloc(this._loginUseCase, this._signUpUseCase, this._confirmUseCase)
      : super(AuthState.initState) {
    on<LoginEvent>((event, emit) async {
      await CoreHelperFunctions.handelMultiApiResult(
          callback: () => _loginUseCase(event.param),
          emit: emit,
          state: state,
          onSuccess: event.onSuccess,
          index: AuthState.login);
    });

    on<SignUpEvent>((event, emit) async {
      await CoreHelperFunctions.handelMultiApiResult(
          callback: () => _signUpUseCase(event.param),
          emit: emit,
          state: state,
          onSuccess: event.onSuccess,
          index: AuthState.signUp);
    });

    on<ConfirmEvent>((event, emit) async {
      await CoreHelperFunctions.handelMultiApiResult(
          callback: () => _confirmUseCase(event.param),
          emit: emit,
          state: state,
          onSuccess: event.onSuccess,
          index: AuthState.confirm);
    });
  }
}
