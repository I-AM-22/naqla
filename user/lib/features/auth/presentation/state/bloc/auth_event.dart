part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginParam param;
  final Function(dynamic) onSuccess;

  LoginEvent(this.param, this.onSuccess);
}

class SignUpEvent extends AuthEvent {
  final SignUpParam param;
  final Function(dynamic) onSuccess;

  SignUpEvent(this.param, this.onSuccess);
}
