part of 'auth_bloc.dart';

class AuthState<T> {
  static int login = 0;
  static int signUp = 1;
  static int confirm = 2;

  static Map<int, CommonState> get initState => {
        login: const InitialState<AuthModel>(),
        signUp: const InitialState<String>(),
        confirm: const InitialState<AuthModel>(),
      };
}
