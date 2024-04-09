part of 'auth_bloc.dart';

class AuthState extends StateObject<AuthState> {
  static String login = "login";
  static String signUp = "signUp";
  static String confirm = "Confirm";

  AuthState([States? states])
      : super(
          [
            InitialState<String>(login),
            InitialState<String>(signUp),
            InitialState<AuthModel>(confirm),
          ],
          (states) => AuthState(states),
          states,
        );
}
