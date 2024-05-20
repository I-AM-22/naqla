part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginParam param;
  final VoidCallback onSuccess;

  LoginEvent({required this.param, required this.onSuccess});
}

class SignUpEvent extends AuthEvent {
  final SignUpParam param;
  final VoidCallback onSuccess;

  SignUpEvent({required this.param, required this.onSuccess});
}

class ConfirmEvent extends AuthEvent {
  final String otp;
  final VoidCallback onSuccess;

  ConfirmEvent({required this.otp, required this.onSuccess});
}
