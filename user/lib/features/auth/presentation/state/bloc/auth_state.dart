part of 'auth_bloc.dart';

class AuthState<T> {
  static int signIn = 0;
  static int firstStepRegister = 1;
  static int secondStepRegister = 2;
  static int locationMap = 3;
  static int thirdStepRegister = 4;
  static int resendCode = 5;
  static int editPhoneNumber = 6;
  static int verifyPhoneNumber = 7;

  static Map<int, CommonState> get initState => {
        signIn: const InitialState<AuthModel>(),
        firstStepRegister: const InitialState<AuthModel>(),
        secondStepRegister: const InitialState<AuthModel>(),
        locationMap: const InitialState<LocationData>(),
        thirdStepRegister: const InitialState<AuthModel>(),
        resendCode: const InitialState<bool>(),
        editPhoneNumber: const InitialState<bool>(),
        verifyPhoneNumber: const InitialState<bool>(),
      };
}
