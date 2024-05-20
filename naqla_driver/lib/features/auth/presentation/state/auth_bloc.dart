import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/auth/data/model/login_model.dart';
import 'package:naqla_driver/features/auth/domain/usecases/login_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/signup_use_case.dart';
import 'package:naqla_driver/features/auth/domain/usecases/verification_phone_number_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final VerificationPhoneNumberUseCase verificationPhoneNumberUseCase;
  AuthBloc(this.loginUseCase, this.signUpUseCase, this.verificationPhoneNumberUseCase) : super(AuthState()) {
    multiStateApiCall<LoginEvent, String>(
      AuthState.login,
      (event) => loginUseCase(event.param),
      onSuccess: (data, event, emit) async {
        emit(state.copyWith(phoneNumber: event.param.phoneNumber));
        event.onSuccess();
      },
    );

    multiStateApiCall<SignUpEvent, String>(
      AuthState.signUp,
      (event) => signUpUseCase(event.param),
      onSuccess: (data, event, emit) async {
        emit(state.copyWith(phoneNumber: event.param.phoneNumber));
        event.onSuccess();
      },
    );

    multiStateApiCall<ConfirmEvent, LoginModel>(
      AuthState.confirm,
      (event) => verificationPhoneNumberUseCase(VerificationPhoneNumberParam(otp: event.otp, phone: state.phoneNumber)),
      onSuccess: (data, event, emit) async => event.onSuccess(),
    );
  }
}
