part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final LoginParam param;

  LoginEvent(this.param);
}
