part of 'auth_bloc.dart';

class AuthState<T> {
  static int login = 0;
  static int signUp = 1;
  static int locationMap = 3;
  static int resendCode = 5;
  static int editPhoneNumber = 6;
  static int verifyPhoneNumber = 7;

  static Map<int, CommonState> get initState => {
        login: const InitialState<AuthModel>(),
        signUp: const InitialState<AuthModel>(),
        locationMap: const InitialState<LocationData>(),
        resendCode: const InitialState<bool>(),
        editPhoneNumber: const InitialState<bool>(),
        verifyPhoneNumber: const InitialState<bool>(),
      };
}
